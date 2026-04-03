import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/item_image.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class Features extends StatelessWidget {
  List<String> features = ["Restaurantes", "Bebidas", "Mercados", "Farmácias"];

  Features({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Obtém o tamanho de tela
    var size = MediaQuery.of(context).size;

    //Define a largura mínima para cada card
    double maxCardWidth = 250.0;
    double minCardWidth = 250.0;

    //Calcula o número de colunas
    int crossAxisCount = (size.width / minCardWidth).floor();

    // Calcula a largura real dos Cards dentro do intervalo especificado
    double cardWidth = size.width / crossAxisCount;
    if (cardWidth > maxCardWidth) {
      crossAxisCount = (size.width / maxCardWidth).floor();
      cardWidth = size.width / crossAxisCount;
    }

    crossAxisCount = max(2, crossAxisCount);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Features", style: AppTextStyles.headline1)],
            ),
          ),
          SizedBox(
            child: createGridView(crossAxisCount, cardWidth, maxCardWidth),
            height: maxCardWidth,
          ),
        ],
      ),
    );
  }

  Widget createGridView(
    int crossAxisCount,
    double cardWidth,
    double maxCardWidth,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: cardWidth / maxCardWidth,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: features.length,
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: FeaturesGridCard(title: features[index]),
        );
      },
    );
  }
}

class FeaturesGridCard extends StatelessWidget {
  final String title;

  const FeaturesGridCard({Key? key, required this.title}) : super(key: key);

  Widget _bodyGrid() {
    return GridTile(
      header: GridTileBar(
        title: Text(title, style: const TextStyle(color: Colors.black)),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  /*width: 16,
                      height: 16,*/
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECDF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/placeholder.png",
                      /*ItemImage.placeHolder().address,*/
                      fit: BoxFit.fill,
                    ),
                    /*child: Flexible(
                      child: Image.asset(
                        ItemImage.placeHolder().address,
                        fit: BoxFit.fill,
                      ),
                    ),*/
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _bodyGrid();
  }
}
