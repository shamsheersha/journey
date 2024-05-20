import 'package:flutter/material.dart';
import 'package:journey/fonts/fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: bold,
        ),
        backgroundColor: Colors.indigo[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: privacytitles,
              ),
              Text(
                'This privacy policy applies to the Journey app (hereby referred to as "Application") for mobile devices that was created by (hereby referred to as "Service Provider") as a Free service. This service is intended for use "AS IS".',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Information Collection and Use',
                style: privacytitles,
              ),
              Text(
                'The Application collects information when you download and use it. This information may include information such as',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. Your device's Inernet Protocol address\n(e.g. IP address)",
                      style: inriaGoogleFont2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '2. The Pages of the Application that you visit, the time and date of your  visit, \nthe time spent on those pages',
                      style: inriaGoogleFont2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '3. The time spent on the Application',
                      style: inriaGoogleFont2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Text(
                'The Application does not gather precise information about the location of your mobile device.',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'The Service Provider may use the information you provided to contact you from time to time to provide you with important information,',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'For a better experience, while using the Application, the Service Provider may require you to provide us with certain personally \nidentifiable information, including but not limited to username profile photo . The information that the Service Provider request will be retained by them and used as described in this privacy policy.',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Third Part Access',
                style: privacytitles,
              ),
              Text(
                'Only aggregated. anonymized data is peridically transmitted to external sevices to aid the Service Provider inimproving th Application and their servie.The Service Provider may share your information with third parties in the ways that are described in this privacy statement.',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'The Service Provider may disclose User Provided and Automatically Collected Information:',
                style: inriaGoogleFont2,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      '1. as required by law, such as to comply with a subpoena, or similar legal process;',
                      style: inriaGoogleFont2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2. when they believe in good faith that disclosure is necessary to protect their rights,protect your safety of others, investigate fraud, or respond to a government request;',
                      style: inriaGoogleFont2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'with their trusted services pproviders who work on their behalf,do not have an independent use of the information we disclose to them, and have agreed to adgere to the rules set forth in this privacy statement.',
                      style: inriaGoogleFont2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Text(
                'Opt-Out Rights',
                style: privacytitles,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Security',
                style: privacytitles),
              const SizedBox(
                height: 10,
              ),
              Text(
                'The Service Provider is concerned about safeguarding the confidentiality of your information. The Service Provider provides physical, electronic, and procedural safeguards to protect information the Service Provider processes and maintains.',
                style: inriaGoogleFont2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Contact Us',
                style: privacytitles,
              ),
              Text(
                'If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at shamsheersha567@gmail.com.',
                style: inriaGoogleFont2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
