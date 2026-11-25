import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../cubit/booking/booking_cubit.dart';
import '../../../cubit/booking/booking_state.dart';

final class PovBookingBlocListener
    extends BlocListener<BookingCubit, BookingState> {
  const PovBookingBlocListener({super.key, super.child})
    : super(listenWhen: _isSuccess, listener: _close);

  static bool _isSuccess(BookingState previous, BookingState current) =>
      current is BookingSuccess;

  static void _close(BuildContext context, BookingState state) =>
      Navigator.of(context).maybePop();
}
