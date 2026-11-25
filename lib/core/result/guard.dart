import 'failure.dart';
import 'result.dart';

Future<Result<T>> guard<T>(Future<T> Function() body) async {
  try {
    return Ok(await body());
  } on AppException catch (e) {
    return Err(Failure(e.message));
  } catch (_) {
    return const Err(Failure('Something went wrong. Please try again.'));
  }
}
