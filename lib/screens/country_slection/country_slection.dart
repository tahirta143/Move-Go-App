import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class CountrySlection extends StatefulWidget {
  const CountrySlection({super.key});

  @override
  State<CountrySlection> createState() => _CountrySlectionState();
}

class _CountrySlectionState extends State<CountrySlection> {
  Country? _selectedCountry;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Country> _filteredCountries = [];
  List<Country> _allCountries = [];

  @override
  void initState() {
    super.initState();
    // Load all countries from the package
    _allCountries = CountryService().getAll();
    _filteredCountries = _allCountries;

    // Select Angola by default
    final angola = _allCountries.firstWhere(
          (c) => c.countryCode == 'AO',
      orElse: () => _allCountries.first,
    );
    _selectedCountry = angola;

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _searchQuery = query;
        _filteredCountries = query.isEmpty
            ? _allCountries
            : _allCountries
            .where((c) =>
        c.name.toLowerCase().contains(query) ||
            c.countryCode.toLowerCase().contains(query) ||
            c.currencyCode!.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;
    final double hp = sw * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: sh * 0.015),

            // ── App Bar ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hp),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: sw * 0.05,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: sw * 0.03),
                  Text(
                    'Seleção de País',
                    style: TextStyle(
                      fontSize: sw * 0.052,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: sh * 0.02),

            // ── Header Card ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hp),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.05,
                  vertical: sh * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sw * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selecione o seu país',
                      style: TextStyle(
                        fontSize: sw * 0.046,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF15305B),
                      ),
                    ),
                    SizedBox(height: sh * 0.007),
                    Text(
                      'Escolha onde você está para personalizarmos sua experiência e moeda local.',
                      style: TextStyle(
                        fontSize: sw * 0.035,
                        color: const Color(0xFF888888),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: sh * 0.015),

            // ── Search Bar ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hp),
              child: Container(
                height: sh * 0.055,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sw * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(fontSize: sw * 0.037),
                  decoration: InputDecoration(
                    hintText: 'Pesquisar país...',
                    hintStyle: TextStyle(
                      color: const Color(0xFFAAAAAA),
                      fontSize: sw * 0.037,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color(0xFFAAAAAA),
                      size: sw * 0.05,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: sh * 0.015,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: sh * 0.015),

            // ── Country List ──
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hp),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(sw * 0.04),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _filteredCountries.isEmpty
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(sw * 0.1),
                      child: Text(
                        'Nenhum país encontrado',
                        style: TextStyle(
                          fontSize: sw * 0.038,
                          color: const Color(0xFF999999),
                        ),
                      ),
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(sw * 0.04),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: _filteredCountries.length,
                      separatorBuilder: (_, index) => Divider(
                        height: 1,
                        thickness: 1,
                        indent: sw * 0.045 + sw * 0.11 + sw * 0.035,
                        endIndent: sw * 0.045,
                        color: const Color(0xFFEEEEEE),
                      ),
                      itemBuilder: (context, index) {
                        final country = _filteredCountries[index];
                        final isSelected =
                            _selectedCountry?.countryCode ==
                                country.countryCode;

                        return InkWell(
                          onTap: () => setState(
                                  () => _selectedCountry = country),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: sw * 0.045,
                              vertical: sh * 0.015,
                            ),
                            child: Row(
                              children: [
                                // ── Flag ──
                                SizedBox(
                                  width: sw * 0.11,
                                  height: sw * 0.11,
                                  child: Center(
                                    child: Text(
                                      country.flagEmoji,
                                      style: TextStyle(
                                        fontSize: sw * 0.075,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: sw * 0.03),

                                // ── Name + Currency ──
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        country.name,
                                        style: TextStyle(
                                          fontSize: sw * 0.038,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: sh * 0.003),
                                      Text(
                                        country.currencyCode ?? '',
                                        style: TextStyle(
                                          fontSize: sw * 0.032,
                                          color:
                                          const Color(0xFF999999),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ── Radio Button ──
                                Container(
                                  width: sw * 0.055,
                                  height: sw * 0.055,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF1A5DC8)
                                          : const Color(0xFFCCCCCC),
                                      width: isSelected ? 0 : 1.5,
                                    ),
                                    color: isSelected
                                        ? const Color(0xFF1A5DC8)
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? Icon(
                                    Icons.circle,
                                    size: sw * 0.028,
                                    color: Colors.white,
                                  )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom Button ──
            Padding(
              padding: EdgeInsets.fromLTRB(hp, sh * 0.015, hp, sh * 0.035),
              child: SizedBox(
                width: double.infinity,
                height: sh * 0.065,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2A5298), Color(0xFF15305B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(sw * 0.034),
                  ),
                  child: ElevatedButton(
                    onPressed: _selectedCountry == null
                        ? null
                        : () {
                      debugPrint(
                        'Selected: ${_selectedCountry!.name} (${_selectedCountry!.currencyCode})',
                      );
                      // TODO: Handle navigation
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sw * 0.034),
                      ),
                    ),
                    child: Text(
                      'Confirmare Continuar',
                      style: TextStyle(
                        fontSize: sw * 0.046,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on Country {
  get currencyCode => null;
}