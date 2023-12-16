import '../model/login_model.dart';
import '../model/register_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> login(LoginModel loginModel);
  Future<Either<Failure, String>> register(RegisterModel registerModel);
}
