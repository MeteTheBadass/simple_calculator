import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cet Calculator',
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  double result = 0;
  String strResult = '0';
  String operator = '';
  double firstNumber;
  double secondNumber;
  double forMultipleOperations=0;
  String memory= '';
  bool isResultShown=false;
  bool isFirstNumberAfterOperationButton = true;
  bool isOperation=true;





  clearFunc()
  {
    result = 0;
    strResult = '0';
    operator = '';
    firstNumber=null;
    isResultShown=false;
    isFirstNumberAfterOperationButton = true;
    memory='';
    forMultipleOperations=0;
  }

  void onDigitPress(String text) {
    //print('digit pressed $text');

    if (text == '+') {
      operator = text;

      firstNumber = result;

      isFirstNumberAfterOperationButton = true;
      if(isOperation){
        forMultipleOperations=forMultipleOperations+firstNumber;
      if(!isResultShown){
        memory=memory+firstNumber.toString()+'+';
      }else if(isResultShown){
        memory=result.toString()+'+';
      }
        isOperation=false;}
      strResult = '';
      setState(() {});
    }else if(text=='-'){

      operator = text;
      firstNumber = result;

      isFirstNumberAfterOperationButton = true;
      if(isOperation){
        if(forMultipleOperations!=0){
          forMultipleOperations=forMultipleOperations-firstNumber;}
        else forMultipleOperations=firstNumber;
        if(!isResultShown){
          memory=memory+firstNumber.toString()+'-';
        }else if(isResultShown){
          memory=result.toString()+'-';
        }
        isOperation=false;}
      strResult = '';
      setState(() {});
      isResultShown=false;
    }else if(text=='÷'){
      operator = text;
      firstNumber = result;

      isFirstNumberAfterOperationButton = true;
      if(isOperation){
        if(forMultipleOperations!=0){
          forMultipleOperations=forMultipleOperations/firstNumber;}
        else forMultipleOperations=firstNumber;
        if(!isResultShown){
          memory=memory+firstNumber.toString()+'÷';
        }else if(isResultShown){
          memory=result.toString()+'÷';
        }
        isOperation=false;}
      strResult = '';
      setState(() {});
    }else if(text=='*'){
      operator = text;
      firstNumber = result;

      isFirstNumberAfterOperationButton = true;
      if(isOperation){
        if(forMultipleOperations!=0){
          forMultipleOperations=forMultipleOperations*firstNumber;}
        else forMultipleOperations=firstNumber;
        if(!isResultShown){
          memory=memory+firstNumber.toString()+'*';
        }else if(isResultShown){
          memory=result.toString()+'*';
        }
        isOperation=false;}
      strResult = '';
      setState(() {});
    }
    else if (text == '=') {

      if(!isResultShown)
        {
          memory=memory+result.toString()+'=';
        }
      else if(isResultShown)
        {
          memory=result.toString()+operator+secondNumber.toString()+'=';
        }
      switch (operator) {
        case '+':
          setState(() {
            if(!isResultShown){
            result = result + forMultipleOperations; forMultipleOperations=0;}
            else if(isResultShown){result=result+secondNumber; forMultipleOperations=0;}
          });
          strResult = '$result';
          isResultShown=true;
          break;
        case '-':
          setState(() {
            if(!isResultShown){
            result = forMultipleOperations-result; forMultipleOperations=0;}
            else if(isResultShown){result=result-secondNumber; forMultipleOperations=0; }
          });
          strResult = '$result';
          isResultShown=true;
          break;
        case '÷':
          setState(() {
            if(!isResultShown)
              {
            result = forMultipleOperations/result; forMultipleOperations=0;}
            else if(isResultShown){result=result/secondNumber; forMultipleOperations=0;}
          });
          strResult = '$result';
          isResultShown=true;
          break;
        case '*':
          setState(() {
            if(!isResultShown)
              {
            result = result * forMultipleOperations; forMultipleOperations=0;}
            else if(isResultShown) {result=result*secondNumber; forMultipleOperations=0;}

          });
          strResult = '$result';
          isResultShown=true;
          break;
      }

    }
    else if(text=='C'){
      setState(() {
        clearFunc();
      });
    } else if(text=='\u232b')
      {
        if(!isResultShown) {
          if (strResult[strResult.length - 1] == '.') {
            strResult = strResult.substring(0, strResult.length - 1);
          }
          strResult = strResult.substring(0, strResult.length - 1);
          if (strResult.length == 0) {
            result=0;
          }

          var temp = double.tryParse(strResult);
          setState(() {
            result = temp ?? result;
          });
        }


      }
    else {
      var tempResult;

      if (isFirstNumberAfterOperationButton) {
        tempResult = text;
        isFirstNumberAfterOperationButton = false;
      } else {
        tempResult = strResult + text;
      }
      if(isResultShown){tempResult=text; isResultShown=false;}
      var temp = double.tryParse(tempResult);
      if (temp != null) {

        strResult = tempResult;


        setState(() {
          result = temp ?? result;
          secondNumber=result;

        });
      }
      isOperation=true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xAA212F3C),
        title: Text('Simple Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  memory,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '$result',
                  style: TextStyle(fontSize: 60),
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('C', Color(0x55515A5A),2),
                  buildCalcButton('\u232b', Color(0x55515A5A),1),
                  buildCalcButton('÷', Color(0xAAF39C12),1),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('7', Colors.black54,1),
                  buildCalcButton('8', Colors.black54,1),
                  buildCalcButton('9', Colors.black54,1),
                  buildCalcButton('*', Color(0xAAF39C12),1),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('4', Colors.black54,1),
                  buildCalcButton('5', Colors.black54,1),
                  buildCalcButton('6', Colors.black54,1),
                  buildCalcButton('+', Color(0xAAF39C12),1),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('1', Colors.black54,1),
                  buildCalcButton('2', Colors.black54,1),
                  buildCalcButton('3', Colors.black54,1),
                  buildCalcButton('-', Color(0xAAF39C12),1),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('.', Colors.black54,1),
                  buildCalcButton('0', Colors.black54,1),
                  buildCalcButton('00', Colors.black54,1),
                  buildCalcButton('=', Color(0xAAF39C12),1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildCalcButton(String text, Color color,int flexNumber) {
    return Expanded(
      flex: flexNumber,
      child: FlatButton(
        onPressed: () {
          onDigitPress(text);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.white,
              width: 1.0,
              style: BorderStyle.solid,
            )),
        color: color,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


}