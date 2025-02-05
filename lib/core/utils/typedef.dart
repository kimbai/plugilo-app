import 'package:dartz/dartz.dart';
import 'package:plugilo/core/network/api_response.dart';

typedef ResultFuture<T> = Future<Either<ApiRespExeption, T>>;

// typedef ResultFutureVoid = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;
