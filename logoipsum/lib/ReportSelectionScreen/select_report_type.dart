import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logoipsum/ReportSelectionScreen/widgets/CustomButtons.dart';

class SelectReport extends StatelessWidget {
  const SelectReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Report Type'),
          centerTitle: true,
          elevation: 4.0,
          surfaceTintColor: Colors.blue[900],
        ),
        body: Container(
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Engineers Australia approved sampled for Free',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Image(
                    image: AssetImage('assets/images/report.png'),
                    width: 180,
                    height: 240,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Choose Your Report Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomButton(argument: 'CDR', buttonText: 'CDR Report'),
                        const SizedBox(height: 10),
                        CustomButton(
                            argument: 'ACSRL', buttonText: 'ACSRL Report'),
                        const SizedBox(height: 10),
                        CustomButton(
                            argument: 'KA02', buttonText: 'KA02 Report'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
