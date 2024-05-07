import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/widgets/second_news_item_desgin.dart';

class SavedViewbody extends StatelessWidget {
  const SavedViewbody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SecondNewsItemDesgin(
          newsModel: NewsModel(
            author: 'Muhannd Alnjjar',
            title:
                'A Vast New Dataset Could Supercharge the AI Hunt for Crypto Money Laundering',
            description:
                'Blockchain analysis firm Elliptic, MIT, and IBM, have released a new AI detection model—and the 200-million-transaction dataset its trained on—that aims to spot the “shape” of Bitcoin money laundering.',
            url:
                'https://www.wired.com/story/ai-crypto-tracing-model-money-laundering/',
            urlToImage:
                'https://readwrite.com/wp-content/uploads/2024/04/zxDgyfq8QYCzJhRAH2CF1g.jpg',
            publishedAt: DateTime.parse('2024-04-17T16:43:29Z'),
            content:
                'The Grayscale Bitcoin Trust (GBTC), a prominent Bitcoin investment product, has seen a significant decline in its Bitcoin (BTC) holdings. This is despite the outflows recently slowing down.\r\nAccordin… [+2125 chars]',
          ),
        ),
      ],
    );
  }
}
