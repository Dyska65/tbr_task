import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_tbr/country.dart';
import 'package:test_tbr/get_countries.dart';
import 'package:test_tbr/list_view_country.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({Key? key}) : super(key: key);

  @override
  _InputPhoneNumberState createState() => _InputPhoneNumberState();
}

List<Country> allCountry = [];

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool isLoaded = false;
  Country? country;
  String currentCountryCode = '';
  var maskFormatter = MaskTextInputFormatter(
      mask: '####-####', filter: {"#": RegExp(r'[0-9]')});
  late double width;

  Future<void> loadData() async {
    try {
      allCountry = await getCountries();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(onChange);
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentCountryCode = Localizations.localeOf(context).countryCode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    if (allCountry.isNotEmpty) {
      country == null
          ? country = allCountry
              .firstWhere((country) => country.nametag == currentCountryCode)
          : null;
    }

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(
            maxHeight: double.infinity, maxWidth: double.infinity),
        padding: const EdgeInsets.fromLTRB(20, 80, 11, 10),
        color: const Color(0xFF8EAAFB),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              title(),
              Row(children: [chooseCountry(), formForInputNumber()])
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: _controller.text.length == 14
            ? const Color(0xFFFFFFFF)
            : const Color(0x99F4F5FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
          if (_controller.text.length == 14) {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You enter mobile number')),
              );
            }
          }
        },
        child: const Icon(
          Icons.arrow_forward,
          color: Color(0xFF7886B8),
        ),
      ),
    );
  }

  Widget title() {
    return const AspectRatio(
      aspectRatio: 1.47,
      child: Text(
        'Get Started',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'Inter',
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget chooseCountry() {
    return Container(
      width: width / 5,
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0x99F4F5FF)),
      child: AspectRatio(
        aspectRatio: 1.4,
        child: TextButton(
          onPressed: () async {
            country = await showModalBottomSheet<Country>(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return const ListAllCountry();
                });
            setState(() {});
          },
          child: isLoaded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      country?.flag ?? allCountry[0].flag,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(
                      country?.code ?? allCountry[0].code,
                      style: const TextStyle(
                        color: Color(0xFF594C74),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget formForInputNumber() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      width: width / 1.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0x99F4F5FF)),
      child: AspectRatio(aspectRatio: 8, child: inputNumber()),
    );
  }

  Widget inputNumber() {
    return TextFormField(
      controller: _controller,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        color: Color(0xFF594C74),
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          hintText: "(011) 222-5555",
          hintStyle: TextStyle(
            color: Color(0xFF7886B8),
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: [maskFormatter],
      maxLines: 1,
    );
  }

  void onChange() {
    _controller.value = maskFormatter.updateMask(mask: "(###) ###-####");
    setState(() {});
  }
}
