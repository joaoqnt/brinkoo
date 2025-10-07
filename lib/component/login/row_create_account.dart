import 'package:brinquedoteca_flutter/view/login/login_create_account_view.dart';
import 'package:flutter/material.dart';

class RowCreateAccount extends StatelessWidget {
  String text;
  String textButton;
  Widget? view;

  RowCreateAccount({
    super.key,
    this.text = "Não tem uma conta?",
    this.textButton = "Cadastre-se",
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(width: 4), // espaçamento pequeno entre os textos
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.push(context, MaterialPageRoute(builder: (context) => view??LoginCreateAccountView(),));
            FocusScope.of(context).unfocus();
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero, // remove padding padrão
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            textButton,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
