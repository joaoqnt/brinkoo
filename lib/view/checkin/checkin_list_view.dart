import 'package:brinquedoteca_flutter/component/checkin/card_checkin.dart';
import 'package:brinquedoteca_flutter/component/checkin/card_checkin_timer.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/checkin/checkin_list_controller.dart';
import 'package:brinquedoteca_flutter/view/checkin/cadastro_checkin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CheckinListView extends StatefulWidget {
  const CheckinListView({super.key});

  @override
  State<CheckinListView> createState() => _CheckinListViewState();
}

class _CheckinListViewState extends State<CheckinListView> {
  final _controller = CheckinListController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.getCheckins(); // carrega a primeira página

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !_controller.isLoading) {
        await _controller.getCheckins(); // carrega mais quando chega no final
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Check-in",
        useDrawer: true,
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Observer(
          builder: (context) {
            return Column(
              spacing: 10,
              children: [
                RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  onChanged: (p0) async {
                    await _controller.getCheckins(refresh: true); // pesquisa reseta
                  },
                  widget: CadastroCheckinView(),
                ),
                Expanded(
                  child: _controller.checkins.isEmpty && _controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    controller: _scrollController,
                    itemCount: _controller.checkins.length +
                        1, // +1 pro loader no fim
                    itemBuilder: (context, index) {
                      if (index < _controller.checkins.length) {
                        final checkin = _controller.checkins[index];
                        return CardCheckin(checkin: checkin);
                      } else {
                        return _controller.isLoading
                            ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                              child: CircularProgressIndicator()),
                        )
                            : const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

