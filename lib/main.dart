import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String searchWord = '';
  List<String> answerResults = [];
  List<String> questionResults = [];
  bool isEnglish = true;

  final List<String> adverbPronounsPrepositions = [
    "i",
    "you",
    "he",
    "she",
    "it",
    "we",
    "they",
    "me",
    "you",
    "him",
    "her",
    "it",
    "us",
    "them",
    "mine",
    "yours",
    "his",
    "hers",
    "its",
    "ours",
    "theirs",
    "this",
    "that",
    "the",
    "theses",
    "those",
    "is",
    "are",
    "about",
    "above",
    "across",
    "after",
    "against",
    "along",
    "among",
    "around",
    "at",
    "before",
    "behind",
    "below",
    "beneath",
    "beside",
    "between",
    "beyond",
    "by",
    "down",
    "during",
    "except",
    "for",
    "from",
    "in",
    "inside",
    "into",
    "like",
    "near",
    "of",
    "off",
    "on",
    "over",
    "through",
    "to",
    "toward",
    "under",
    "up",
    "with",
    "without",
    "where",
    "when",
    'why',
    "how",
    "how much",
    "how many",
    "who",
    "what",
    "which",
    "such",
    "so"
  ];

  final List<String> adverbPrenomPrepositions = [
    "je",
    "tu",
    "il",
    "elle",
    "ils",
    "elles",
    "nous",
    "vous",
    "à",
    "chez",
    "dans",
    "de",
    "depuis",
    "durant",
    "en",
    "entre",
    "jusqu'à",
    "par",
    "pour",
    "sans",
    "sous",
    "sur",
    "vers",
    "avec",
    "avant",
    "après",
    "pendant",
    "derrière",
    "devant",
    "contre",
    "entre",
    "auprès",
    "au",
    "aux",
    "du",
    "des",
    "vos",
    "nos",
    "votre",
    "notre",
    "l",
    "que",
    "comment",
    'combien',
    "comme ",
    "sont",
    "quoi",
    "qui",
    "quand",
    "ou",
    "quel",
    "quels",
    "quelle",
    "quelles",
    "lequel",
    "laquelle",
    "lesquels",
    "lesquelles",
    "le",
    "la",
    "les",
    "un",
    "une"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey.shade300,
            actions: [
              TextButton(
                  onPressed: () => setState(() {
                        isEnglish = !isEnglish;
                        questionResults = [];
                        answerResults = [];
                        searchWord = "";
                      }),
                  child: Text(isEnglish ? "En" : "Fr"))
            ],
            leading: InkWell(
                onTap: (() => Navigator.pop(context)),
                child: const Icon(Icons.arrow_back)),
            centerTitle: true,
            title: const Text('Chatbot')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: questionResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: questionResults.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  questionResults[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            subtitle: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, right: 40),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    answerResults[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 16),
                                  )),
                            ),
                            onTap: () => showValue(questionResults[index]),
                          );
                        },
                      )
                    : Center(
                        child: Text(isEnglish
                            ? "please specify your question.... "
                            : "veuillez préciser votre question s'il vous plait..."),
                      )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          labelText: isEnglish
                              ? 'ask your question'
                              : 'posez vos question',
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchWord = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      color: Colors.black,
                      onPressed: () => search(searchWord),
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void showValue(String key) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(key),
          content: Text(
            isEnglish
                ? enQuestionsAndResponses[key]!
                : frQuestionsAndResponses[key]!,
            style: const TextStyle(fontSize: 12),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(isEnglish ? 'Close' : "Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void search(String word) {
    List<Map<String, dynamic>> matches = [];

    // Remove adverbPrenomPrepositions from the search word
    List<String> searchWords = word
        .toLowerCase()
        .replaceAll(RegExp(r"[-'?]"), ' ')
        .replaceAll(RegExp(r"[êéè]"), 'e')
        .trim()
        .split(' ')
        .where((word) {
      if (isEnglish) {
        return !adverbPronounsPrepositions.contains(word);
      } else {
        return !adverbPrenomPrepositions.contains(word);
      }
    }).map((word) {
      if (isEnglish) {
        return word.endsWith('s')
            ? word.substring(0, word.length - 1)
            : word.endsWith('ly') || word.endsWith('ed')
                ? word.substring(0, word.length - 2)
                : word.endsWith('ing')
                    ? word.substring(0, word.length - 3)
                    : word;
      } else {
        return word.endsWith('s') || word.endsWith('z') || word.endsWith('r')
            ? word.substring(0, word.length - 1)
            : word;
      }
    }).toList();
    print("search $searchWords");

    (isEnglish ? enQuestionsAndResponses : frQuestionsAndResponses)
        .forEach((key, value) {
      // Split key into words and remove punctuation and adverbPrenomPrepositions
      List<String> questionWords = key
          .toLowerCase()
          .replaceAll(RegExp(r"[-'?]"), ' ')
          .replaceAll(RegExp(r"[êéè]"), 'e')
          .trim()
          .split(' ')
          .where((word) {
        if (isEnglish) {
          return !adverbPronounsPrepositions.contains(word);
        } else {
          return !adverbPrenomPrepositions.contains(word);
        }
      }).map((word) {
        if (isEnglish) {
          return word.endsWith('s')
              ? word.substring(0, word.length - 1)
              : word.endsWith('ly') || word.endsWith('ed')
                  ? word.substring(0, word.length - 2)
                  : word.endsWith('ing')
                      ? word.substring(0, word.length - 3)
                      : word;
        } else {
          return word.endsWith('s') || word.endsWith('z') || word.endsWith('r')
              ? word.substring(0, word.length - 1)
              : word;
        }
      }).toList();

      int score = intersect(questionWords, searchWords).length;

      if (score > 0) {
        matches.add({'question': key, 'answer': value, 'score': score});
      }
    });

    // Sort matches by score in descending order
    matches.sort((a, b) => b['score'].compareTo(a['score']));

    setState(() {
      questionResults =
          matches.map((match) => match['question'] as String).toList();
      answerResults =
          matches.map((match) => match['answer'] as String).toList();
    });
  }

  List<String> intersect(List<String> p1, List<String> p2) {
    List<String> answer = [];

    print('p1 : $p1');
    print('p2 : $p2');
    for (String word1 in p1) {
      for (String word2 in p2) {
        if (word1 == word2 || word1.contains(word2)) {
          // If a match is found, add it to the answer list
          answer.add(word1);
        }
      }
    }
    return answer;
  }

  Map<String, String> frQuestionsAndResponses = {
    "Qui êtes-vous ?":
        "Nous sommes Viamobile, un établissement de paiement en ligne agréé par la banque centrale.",
    "Que faites-vous ?":
        "Nous proposons des services financiers sécurisés tels que l'envoi, la réception et le transfert d'argent à tout moment et en tout lieu. Nous avons également de nombreux partenaires auprès desquels vous pouvez régler vos factures.",
    "D'où pouvez-vous envoyer ou recevoir de l'argent ?":
        "Vous pouvez envoyer de l'argent, recevoir des paiements et régler vos factures via nos agents présents dans chaque région. Si vous souhaitez localiser un agent près de chez vous, cliquez sur le bouton ci-dessous.",
    "Quels services offrez-vous ?":
        "Nous offrons des services de paiement mobile, de transfert d'argent et de paiement de factures.",
    "Comment contacter le support client ?":
        "Vous pouvez contacter notre support client via l'application ou par téléphone au numéro indiqué sur notre site.",
    "Quels sont vos partenaires ?":
        "Nos partenaires incluent des banques locales, des entreprises de télécommunications et des points de vente au détail.",
    "Comment sécurisez-vous vos transactions ?":
        "Nous utilisons des technologies de cryptage avancées pour garantir la sécurité de vos transactions.",
    "Quels sont les frais pour vos services ?":
        "Les frais pour nos services varient en fonction du type de transaction et sont affichés de manière transparente avant chaque opération.",
    "Puis-je utiliser vos services à l'international ?":
        "Oui, nos services sont disponibles à l'international dans les pays où nous avons des partenaires.",
    "Comment ouvrir un compte ?":
        "Pour ouvrir un compte, téléchargez notre application, suivez les étapes d'inscription et vérifiez votre identité.",
    "Quels documents sont nécessaires pour l'inscription ?":
        "Vous aurez besoin d'une pièce d'identité valide et d'un justificatif de domicile pour vous inscrire.",
    "Comment effectuer un transfert d'argent ?":
        "Pour effectuer un transfert d'argent, sélectionnez l'option 'Transfert' dans l'application, entrez les détails du bénéficiaire et confirmez la transaction.",
    "Puis-je annuler un transfert ?":
        "Les transferts peuvent être annulés dans un délai d'une heure après la confirmation, sous réserve des conditions de notre politique d'annulation.",
    "Que faire en cas de problème avec une transaction ?":
        "En cas de problème avec une transaction, contactez immédiatement notre support client pour assistance.",
    "Comment consulter l'historique des transactions ?":
        "Vous pouvez consulter l'historique de vos transactions dans la section 'Historique' de notre application.",
  };

  Map<String, String> enQuestionsAndResponses = {
    "Who are you?":
        "We are Viamobile, an online payment institution authorized by the central bank.",
    "What do you do?":
        "We offer secure financial services such as sending, receiving, and transferring money at any time and from anywhere. We also have many partners where you can pay your bills.",
    "Where can you send or receive money from?":
        "You can send money, receive payments, and pay your bills via our agents present in every region. If you want to locate an agent near you, click the button below.",
    "What services do you offer?":
        "We offer mobile payment services, money transfer, and bill payment.",
    "How to contact customer support?":
        "You can contact our customer support via the app or by phone at the number indicated on our website.",
    "Who are your partners?":
        "Our partners include local banks, telecommunications companies, and retail outlets.",
    "How do you secure your transactions?":
        "We use advanced encryption technologies to ensure the security of your transactions.",
    "What are the fees for your services?":
        "The fees for our services vary depending on the type of transaction and are transparently displayed before each operation.",
    "Can I use your services internationally?":
        "Yes, our services are available internationally in countries where we have partners.",
    "How to open an account?":
        "To open an account, download our app, follow the registration steps, and verify your identity.",
    "What documents are needed for registration?":
        "You will need a valid ID and proof of address to register.",
    "How to make a money transfer?":
        "To make a money transfer, select the 'Transfer' option in the app, enter the recipient's details, and confirm the transaction.",
    "Can I cancel a transfer?":
        "Transfers can be canceled within one hour after confirmation, subject to the conditions of our cancellation policy.",
    "What to do in case of a problem with a transaction?":
        "In case of a problem with a transaction, contact our customer support immediately for assistance.",
    "How to check transaction history?":
        "You can check your transaction history in the 'History' section of our app."
  };
}
