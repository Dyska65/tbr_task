import 'package:flutter/material.dart';
import 'package:test_tbr/country.dart';
import 'package:test_tbr/page_input.dart';

class ListAllCountry extends StatefulWidget {
  const ListAllCountry({Key? key}) : super(key: key);

  @override
  _ListAllCountryState createState() => _ListAllCountryState();
}

class _ListAllCountryState extends State<ListAllCountry> {
  final _searchview = TextEditingController();
  List<Country> _filterList = [];

  _ListAllCountryState() {
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        setState(() {});
      } else {
        filteringList();
      }
    });
  }

  filteringList() {
    List<Country> filtr = [];
    String firstLetter = _searchview.text.trimLeft().substring(0, 1);

    for (var country in allCountry) {
      if (firstLetter == '+') {
        country.code.contains(_searchview.text) ? filtr.add(country) : null;
      } else {
        country.name.contains(_searchview.text) ? filtr.add(country) : null;
      }
    }
    setState(() {
      _filterList = filtr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF8EAAFB),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Country code',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'Inter',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                )),
            Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0x99F4F5FF)),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: const Color(0xFF594C74),
                iconSize: 20,
              ),
            )
          ],
        ),
        search(),
        Expanded(
          child: listViewCountry(),
        )
      ]),
    );
  }

  Widget search() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0x99F4F5FF)),
        child: AspectRatio(
            aspectRatio: 17,
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Color(0xFF594C74),
                  size: 25,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: inputQuery()),
              ],
            )),
      ),
    );
  }

  Widget inputQuery() {
    return SizedBox(
      child: TextFormField(
        controller: _searchview,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          color: Color(0xFF594C74),
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.all(5),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
              color: Color(0xFF7886B8),
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }

  Widget listViewCountry() {
    final list = _searchview.text.isNotEmpty ? _filterList : allCountry;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          contentPadding: EdgeInsets.all(0),
          // minLeadingWidth: 10,
          onTap: () {
            Navigator.pop(context, list[index]);

            print(" ${list[index].name}");
          },
          leading: Text(
            list[index].flag,
            style: const TextStyle(fontSize: 40),
          ),
          title: Row(
            children: [
              Text(
                list[index].code,
                style: const TextStyle(
                  color: Color(0xFF594C74),
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  list[index].name,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
