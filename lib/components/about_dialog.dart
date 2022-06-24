import 'package:flutter/material.dart';
import 'package:ny_tiona/config/config.dart';
import 'package:package_info/package_info.dart';

Future<void> showAboutAppDialog(BuildContext parentContext) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return showDialog<void>(
    context: parentContext,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            const CircleAvatar(
              foregroundImage: AssetImage('assets/icon/logo.png'),
              backgroundColor: Colors.white,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  '${packageInfo.appName} ${packageInfo.version}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text(
                "Novokarina ho an’ EKLESIA  EPISKOPALY MALAGASY. Ho fampahafantarana sy fanapariahana ireo Hira Fifaliana sy Fiderana fanao amin'ny Kristmasy.",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  text: "",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: fontFamily,
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Directeur de projet:\n",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: "Haribenja Ramaromanda\n",
                    ),
                    TextSpan(
                      text: "Contributeur:\n",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: "Hery Nirintsoa\n",
                    ),
                    TextSpan(
                      text: "Contact:\n",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: "haribenja@yahoo.fr",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
