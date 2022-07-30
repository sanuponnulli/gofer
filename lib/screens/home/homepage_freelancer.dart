import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/home/homepage_client.dart';
import 'package:flutter_application_1/screens/login/login_page_client.dart';
import 'package:flutter_application_1/screens/wallet/freelancer_wallet.dart';

import '../addjobs/add_jobs.dart';
import '../messages/messages_screen.dart';
import '../proposals/proposals_client.dart';
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
      SafeArea(child: Text("sss"))
    ];
    return HomePageClient(pages: freelancerpages, usertype: "Freelancer");
  }
}
