import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/viewmodel/profile/language_edit_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageEditView extends StatelessWidget {
  const LanguageEditView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageEditViewModel(),
      child: Consumer<LanguageEditViewModel>(builder: (context, viewModel, _) {
        return GestureDetector(
          onTap: () => viewModel.languageFocusNode.unfocus(),
          child: Scaffold(
            appBar: const BackAppBar(),
            body: Padding(
              padding: UIHelper.pagePadding(context),
              child: Column(
                children: <Widget>[
                  UIHelper.emptySpaceHeight(context, 0.02),
                  _headlineText(context),
                  UIHelper.emptySpaceHeight(context, 0.04),
                  _searchBox(context, viewModel),
                  UIHelper.emptySpaceHeight(context, 0.02),
                  _languageList(context, viewModel),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _languageList(BuildContext context, LanguageEditViewModel viewModel) =>
      Expanded(
        child: !viewModel.isTyping
            ? ListView.builder(
                itemCount: viewModel.languages.length,
                itemBuilder: (context, index) => _languageTile(
                  context,
                  viewModel.languages[index],
                  viewModel,
                ),
              )
            : ListView.builder(
                itemCount: viewModel.filteredLanguages.length,
                itemBuilder: (context, index) => _languageTile(
                  context,
                  viewModel.filteredLanguages[index],
                  viewModel,
                ),
              ),
      );

  Widget _languageTile(BuildContext context, String language,
          LanguageEditViewModel viewModel) =>
      Padding(
        padding:
            EdgeInsets.only(top: UIHelper.getDynamicHeight(context, 0.016)),
        child: ListTile(
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          tileColor: UIHelper.plaster,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            language,
            style: TextStyle(
              fontSize:
                  UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
              color: UIHelper.saltwaterDenim,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "In Native Language",
            style: TextStyle(
              fontSize:
                  UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
              color: UIHelper.formalGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () async => await viewModel.setLanguage(language),
        ),
      );

  Widget _searchBox(BuildContext context, LanguageEditViewModel viewModel) =>
      TextField(
        controller: viewModel.languageController,
        focusNode: viewModel.languageFocusNode,
        onChanged: (value) => viewModel.searchLanguage(value),
        cursorColor: UIHelper.saltwaterDenim,
        decoration: InputDecoration(
          hintText: "Search languages...",
          hintStyle: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
            fontWeight: FontWeight.w600,
            color: UIHelper.formalGrey,
          ),
          prefixIcon: const Icon(Icons.search, color: UIHelper.formalGrey),
          suffixIcon: viewModel.isTyping
              ? GestureDetector(
                  onTap: () {
                    viewModel.clearSearchText();
                  },
                  child:
                      const Icon(Icons.close, color: UIHelper.saltwaterDenim),
                )
              : const Text(""),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: UIHelper.saltwaterDenim),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: UIHelper.saltwaterDenim),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: UIHelper.saltwaterDenim),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
              EdgeInsets.all(UIHelper.getDynamicHeight(context, 0.016)),
        ),
      );

  Widget _headlineText(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Primary Language",
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
            color: UIHelper.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
