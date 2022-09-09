import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/wallet/freelancer_wallet.dart';

import '../messages/messages_screen.dart';
import '../proposals/proposals_freelancer.dart';
import '../search/search_screen.dart';

class HomepageFreelancer extends StatelessWidget {
  const HomepageFreelancer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> freelancerpages = const [
      SearchScreen(),
      Freelancerproposals(),
      FreelancerWallet(),
      Messagescreen(),
      //SafeArea(child: Text("sss"))
    ];
    return HomePageClient(pages: freelancerpages, usertype: "Freelancer");
  }
}
