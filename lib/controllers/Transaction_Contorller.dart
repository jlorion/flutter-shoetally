

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/models/OrdersModel.dart';
import 'package:commerce_mobile/models/TransactionsModel.dart';

class TransactionContorller {
  CollectionReference ref = FirebaseFirestore.instance.collection('transactions');

  //get Transaction
  Future<List<Transactions>> getTransactions() async{
    final snapshots = await ref.get();
    return snapshots.docs.map((trans)=> Transactions.fromFireStore(trans.data() as Map<String, dynamic>, trans.id)).toList();
  }

  //add Transaction 
  Future<void> addTransaction(Transactions trans, List<Orders> orders)async{
    DocumentReference docref = await ref.add(trans.toJson());
    docref.update({
      'id': docref.id
    });
    orders.forEach((order) async{
      print("this is running");
      DocumentReference callbackDoc = await docref.collection("orders").add(order.toJson());
      callbackDoc.update({
        'id': callbackDoc.id
      });
    });
  }

  Future<List<Orders>> getOrders(String id)async{
    final snapshots= await ref.doc(id).collection("orders").get();
    return snapshots.docs.map((order)=> Orders.fromFireStore(order as Map<String, dynamic>, order.id)).toList();
  }


}