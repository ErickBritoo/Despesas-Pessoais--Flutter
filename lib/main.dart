// ignore_for_file: use_key_in_widget_constructors

import 'dart:math';
import 'package:expenses/componets/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../componets/transaction_form.dart';
import '../componets/transaction_list.dart';
import '../models/transaction.dart';
import 'package:flutter/foundation.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.purple, secondary: Colors.amber),
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              labelSmall: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  bool _showChart = false;
  List<Transaction> get _recentTransaction {
    return _transaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);
    setState(
      () {
        _transaction.add(newTransaction);
      },
    );
    Navigator.of(context).pop(); // == Navigator.pop(context)
  }

  _removeTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) => tr.id == id);
    });
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;
    Object platform = defaultTargetPlatform;
    final iconList =
        platform == TargetPlatform.iOS ? CupertinoIcons.refresh : Icons.list;
    final chartList = platform == TargetPlatform.iOS
        ? CupertinoIcons.refresh
        : Icons.show_chart;
    final actions = <Widget>[
      if (isLandScape)
        _getIconButton(
          _showChart ? iconList : chartList,
          () {
            setState(
              () {
                _showChart = !_showChart;
              },
            );
          },
        ),
      _getIconButton(
        platform == TargetPlatform.iOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final dynamic appBar;

    if (platform == TargetPlatform.iOS) {
      appBar = CupertinoNavigationBar(
        middle: const Text("Despesas Pessoais"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
      );
    } else {
      appBar = AppBar(
        title: const Text(
          "Despesas Pessoais",
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
        actions: actions,
      );
    }

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_showChart || !isLandScape)
                SizedBox(
                  height: availableHeight * (isLandScape ? 0.8 : 0.3),
                  child: Chart(_recentTransaction),
                ),
              if (!_showChart || !isLandScape)
                SizedBox(
                  height: availableHeight * (isLandScape ? 1 : 0.7),
                  child: TransactionList(
                    transactions: _transaction,
                    onRemove: _removeTransaction,
                  ),
                ),
            ]),
      ),
    );

    return platform == TargetPlatform.iOS
        ? CupertinoPageScaffold(navigationBar: appBar, child: bodyPage)
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openTransactionFormModal(context),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
