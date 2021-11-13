
import 'package:clean_achitecture/features/Post/presentation/item_page/address_Post/domain/entity/distric.dart';
import 'package:clean_achitecture/features/Post/presentation/item_page/address_Post/domain/repository/Repository.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_achitecture/error/failures.dart';
import 'package:clean_achitecture/usecase/usecase.dart';

class ChooseWard extends UseCase<void, District> {
  Repository repository;
  ChooseWard({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(District params) {
    repository.chooseWard(params.name.toString());
    throw UnimplementedError();
  }
}
