// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quotes/features/quotes/presentation/bloc/bloc.dart';
// import 'package:quotes/features/quotes/presentation/widgets/widgets.dart';

// // import '../../../../injection_container.dart';

// class QuotePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Number Trivia'),
//       ),
//       body: SingleChildScrollView(
//         child: buildBody(context),
//       ),
//     );
//   }

//   BlocProvider<QuoteBloc> buildBody(BuildContext context) {
//     return BlocProvider(
//       builder: (_) => sl<QuoteBloc>(),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 10),
//               // Top half
//               BlocBuilder<QuoteBloc, QuoteState>(
//                 builder: (context, state) {
//                   if (state is Empty) {
//                     return MessageDisplay(
//                       message: 'Start searching!',
//                     );
//                   } else if (state is Loading) {
//                     return LoadingWidget();
//                   } else if (state is Loaded) {
//                     return QuoteDisplay(quote: state.quote);
//                   } else if (state is Error) {
//                     return MessageDisplay(
//                       message: state.message,
//                     );
//                   }
//                 },
//               ),
//               SizedBox(height: 20),
//               // Bottom half
//               TriviaControls()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
