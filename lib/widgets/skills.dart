import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '/animation/side_transition.dart';
import '/model/skill_model.dart';
import '/provider/skill_provider.dart';
import '/responsive.dart';
import 'package:provider/provider.dart';

class Skills extends StatelessWidget {
  const Skills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SkillModel> _skills =
        Provider.of<SkillProvider>(context, listen: false).getSkills();
    return Column(
      children: [
        Responsive.isSmallScreen(context)
            ? Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    header(true),
                    const SizedBox(
                      height: 50,
                    ),
                    content(context, _skills)
                  ],
                ),
              )
            : Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 110),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: content(context, _skills),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: header(false)),
                  ],
                ),
              ),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.5),
        ),

      ],
    );
  }

  Widget header(bool isMobileView) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
            children: [
              const TextSpan(
                  text: "MY",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              TextSpan(text: isMobileView ? " " : "\n"),
              const TextSpan(
                text: "SKILLS",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ]));
  }

  Widget content(BuildContext context, List<SkillModel> skills) {
    int duration = 500;
    return Column(
      children: [
        RichText(
            textAlign: TextAlign.justify,
            text: const TextSpan(
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                children: [
                  TextSpan(
                      text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  TextSpan(text: "\n\n\n"),
                ])),
        SizedBox(
          height: 85 * skills.length.toDouble(),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                duration += 150;
                return CustomSideTransition(
                  content: skillStats(skills[index].title,
                      skills[index].progress, skills[index].colors),
                  duration: duration,
                );
              }),
        )
      ],
    );
  }

  Widget skillStats(String title, double progress, Color colors) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                decoration: BoxDecoration(
                    color: colors.withOpacity(0.4),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(12.0))),
                child: Text(
                  title,
                  style: TextStyle(color: colors, fontSize: 11),
                ),
              ),
              Text(
                progress.toString() + "%",
                style: TextStyle(color: colors, fontSize: 11),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          LinearPercentIndicator(
            animation: true,
            lineHeight: 14.0,
            animationDuration: 2000,
            percent: progress / 100,
            center: Text(
              progress.toString() + "%",
              style: const TextStyle(color: Colors.white),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: colors,
            backgroundColor: colors.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
