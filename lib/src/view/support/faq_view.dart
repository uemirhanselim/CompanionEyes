import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/viewmodel/support/faq_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FaqViewModel(),
      child: Scaffold(
        appBar: const BackAppBar(),
        body: Padding(
          padding: UIHelper.pagePadding(context),
          child: Align(
            child: Column(
              children: <Widget>[
                _headlineText(context),
                UIHelper.emptySpaceHeight(context, 0.02),
                _body(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) =>
      Consumer<FaqViewModel>(builder: (context, viewModel, _) {
        return ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) => _expansionTile(context,
              "Example Faq $index", "Example Answer $index", viewModel, index),
        );
      });

  Widget _expansionTile(BuildContext context, String title, String description,
          FaqViewModel viewModel, int index) =>
      Padding(
        padding: EdgeInsets.only(
          top: UIHelper.getDynamicHeight(context, 0.02),
        ),
        child: ExpansionTile(
          onExpansionChanged: (value) => viewModel.toggleExpandedList(index),
          backgroundColor: UIHelper.plaster,
          collapsedBackgroundColor: UIHelper.plaster,
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          trailing: Icon(
            viewModel.expandedList[index] ? Icons.remove : Icons.add,
            color: UIHelper.formalGrey,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize:
                  UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
              fontWeight: FontWeight.w600,
            ),
          ),
          childrenPadding: EdgeInsets.only(
            bottom: UIHelper.getDynamicHeight(context, 0.012),
            left: UIHelper.getDynamicWidth(context, 0.042),
            right: UIHelper.getDynamicWidth(context, 0.042),
          ),
          expandedAlignment: Alignment.centerLeft,
          children: [
            Text(
              description,
              style: TextStyle(
                fontSize:
                    UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
                color: UIHelper.formalGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Text _headlineText(BuildContext context) => Text(
        "FAQ",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
}
