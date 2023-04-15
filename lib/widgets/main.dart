
// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import './chart.dart';

import './newTransaction.dart';
import '../models/transaction.dart';

import './transactionList.dart';
import 'package:flutter/material.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  // DeviceOrientation.portraitUp,
  // DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSan',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //  Transaction(
    //     id: 't1',
    //     title: 'New Shoes',
    //     amount: 69.99,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't2',
    //     title: 'Bag',
    //     amount: 169.9999,
    //     date: DateTime.now(),
    //   ),
  ];
  bool _showChart = false;

 

  // ignore: unused_element
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7),),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere( (tx) {
        return tx.id == id;
      },);
    });
  }

  _iphoneNavigator(){
    return CupertinoNavigationBar(
      middle: Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
            )
          
        ],
      ),
    );
  }

  _andriodNavigator(isLandscape){
    return AppBar(
        // ignore: prefer_const_constructors
        title: Text(
          'Personal Expenses',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        toolbarHeight: isLandscape? 40:60,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      );
  }

  List <Widget> _buildLanscapeContent(Widget transactionContainer, Widget chartContainer) {
      return [transactionContainer, chartContainer]; //  Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children:[
          //     Text('Show Chart'),
          //     Switch(value: _showChart, onChanged: ((value) => {
          //       setState(() {
          //         _showChart = value; 
          //       }),
          //     }), ),
          //     ],),

  }

  List <Widget> _buildPortraitContent(MediaQueryData mediaQuery, appBar, Widget transactionContainer) {
    return [Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                child: Chart(_recentTransactions)), 
                transactionContainer];
    
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS ?
      _iphoneNavigator()
    : _andriodNavigator(isLandscape);
     final transactionContainer = Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
              child: TransactionList(_userTransactions, _deleteTransaction));
    
    final chartContainer = Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.5,
              child: Chart(_recentTransactions));
    final pageBody = SafeArea(
      child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if(isLandscape) ..._buildLanscapeContent(chartContainer,transactionContainer),
              if (!isLandscape)  ..._buildPortraitContent(mediaQuery, appBar, transactionContainer),
              
              
            ],
          ),
        )
    );
      
    return Platform.isIOS? CupertinoPageScaffold(child: pageBody, navigationBar: appBar) : Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: appBar,
      body:pageBody, 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS? Container() : FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
