import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/primary_button.dart';
import '../../cubit/booking/booking_cubit.dart';
import '../../cubit/booking/booking_state.dart';
import '../../data/models/requsts/booking_request.dart';

typedef PrimaryButtonBuilder = PrimaryButton Function({
  required String label,
  VoidCallback? onPressed,
  bool isLoading,
});

class BookButton extends StatelessWidget {
  const BookButton._({
    required this.request,
    required this.label,
    required this.buttonBuilder,
  });

  factory BookButton.continueAction({required BookingRequest request}) =>
      BookButton._(
        request: request,
        label: 'Continue',
        buttonBuilder: PrimaryButton.filled,
      );

  factory BookButton.book({
    required BookingRequest request,
    required String totalLabel,
  }) => BookButton._(
    request: request,
    label: 'Book · $totalLabel',
    buttonBuilder: PrimaryButton.light,
  );

  final BookingRequest request;
  final String label;
  final PrimaryButtonBuilder buttonBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) => buttonBuilder(
        label: label,
        isLoading: state.isLoading,
        onPressed: () => context.read<BookingCubit>().book(request),
      ),
    );
  }
}
