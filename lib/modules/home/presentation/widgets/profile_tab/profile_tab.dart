import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/modules/auth/aplication/auth_bloc.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/aplication/theme_bloc.dart';
import 'package:vocabulario_dev/modules/home/presentation/widgets/profile_tab/profile_tab_controller.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/pages/theme_page.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab._();
  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileTabController(
        userInfoStorageReapositoryInterface:
            context.read<UserInfoStorageReapositoryInterface>(),
      )..init(),
      builder: (_, __) => const ProfileTab._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileTabController>();
    final user = controller.user;
    final localization = AppLocalizations.of(context)!;
    final systemPadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: DefaultTheme.padding + systemPadding.top,
            left: DefaultTheme.padding,
            right: DefaultTheme.padding,
            bottom: DefaultTheme.padding + systemPadding.bottom,
          ),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.only(top: DefaultTheme.padding),
            constraints: const BoxConstraints(maxWidth: DefaultTheme.maxWidth),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: user.image == null || user.image?.isEmpty == true
                        ? const Icon(
                            FeatherIcons.user,
                            color: Colors.white,
                          )
                        : Image.network(
                            user.image!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const CircularProgressIndicator();
                            },
                          ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(localization.home_page_tab_profile_change_avatar),
                ),
                const SizedBox(height: DefaultTheme.gap),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PersonalInfoField(
                        label: localization.home_page_tab_profile_label_name,
                        text: '${user.fisrtName} ${user.lastName}',
                      ),
                      const SizedBox(height: DefaultTheme.gap),
                      _PersonalInfoField(
                        label: localization.home_page_tab_profile_label_email,
                        text: user.email,
                      ),
                      const SizedBox(height: DefaultTheme.gap),
                      Text(
                        localization.home_page_tab_profile_category_general,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: DefaultTheme.gap * .5),
                      Card(
                        child: Column(
                          children: [
                            _TouchableOption(
                              label: localization
                                  .home_page_tab_profile_category_general_change_password,
                              rightWidget: const Icon(
                                FeatherIcons.chevronRight,
                              ),
                            ),
                            Divider(
                              height: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            _TouchableOption(
                              onTap: () {
                                Navigator.of(context).pushNamed(ThemePage.path);
                              },
                              label: localization
                                  .home_page_tab_profile_category_general_change_theme,
                              rightWidget: BlocBuilder<ThemeBloc, ThemeState>(
                                builder: (context, state) {
                                  return Text(localization.theme_page_options_title(describeEnum(state.themeMode)));
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: DefaultTheme.gap),
                      OutlinedButton(
                          onPressed: () async {
                            final loginAuth = BlocProvider.of<AuthBloc>(context);
                            loginAuth.add(AuthLogoutRequest());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(localization
                                  .home_page_tab_profile_category_logout),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TouchableOption extends StatelessWidget {
  const _TouchableOption({
    this.onTap,
    required this.label,
    this.rightWidget,
  });
  final GestureTapCallback? onTap;
  final String label;
  final Widget? rightWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            if (rightWidget != null) rightWidget!,
          ],
        ),
      ),
    );
  }
}

class _PersonalInfoField extends StatelessWidget {
  const _PersonalInfoField({
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: DefaultTheme.gap * .5),
        Text(
          text,
        ),
      ],
    );
  }
}
