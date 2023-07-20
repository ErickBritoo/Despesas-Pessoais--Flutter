import 'package:expenses/componets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';

// ignore: must_be_immutable
class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  final void Function(String) onRemove;
  TransactionList(
      {Key? key, required this.transactions, required this.onRemove})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    "Nenhuma Transação Cadastrada",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/img/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(
                  key: GlobalObjectKey(tr), tr: tr, onRemove: onRemove);
            },
          );
    // ListView(
    //     children: transactions.map((tr) {
    //       return TransactionItem(
    //         key: ValueKey(tr.id),
    //         tr: tr,
    //         onRemove: onRemove,
    //       );
    //     }).toList(),
    //   );
  }
}
