import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key, required this.onPageChanged});

  final Function(int) onPageChanged;

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int _currentPage = 1;
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: _currentPage == 1
                  ? null
                  : () {
                      setState(() {
                        _currentPage--;
                      });
                      widget.onPageChanged(_currentPage);
                    },
              icon: const Icon(Icons.arrow_back_ios),
              disabledColor: Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              _currentPage.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPage++;
                });
                widget.onPageChanged(_currentPage);
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
