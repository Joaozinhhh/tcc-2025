import 'package:flutter/material.dart';
import 'package:src/common/widgets/balance_card/balance_card_widget.dart';
import 'package:src/common/widgets/balance_card/balance_card_widget_controller.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/extensions/sizes.dart';
import '../../common/widgets/app_header.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../common/widgets/transaction_listview.dart';
import '../../locator.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = locator.get<HomeController>();
  final balanceController = locator.get<BalanceCardWidgetController>();

  @override
  void initState() {
    super.initState();
    controller.getAllTransactions();
    balanceController.getBalances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppHeader(),
          BalanceCard(controller: balanceController),
          Positioned(
            top: 397.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Histórico de Transações', style: AppTextStyles.mediumText18), Text('Ver todas', style: AppTextStyles.inputLabelText)],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      if (controller.state is HomeStateLoading) {
                        return const CustomCircularProgressIndicator(color: AppColors.azul_escuro);
                      }
                      if (controller.state is HomeStateError) {
                        return const Center(child: Text('Ocorreu um erro ao carregar as transações.'));
                      }
                      if (controller.state is HomeStateSuccess) {
                        return TransactionListView(transactionList: controller.transactions, itemCount: 5);
                      }
                      return const Center(child: Text('Nenhuma Transação até o momento.'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
