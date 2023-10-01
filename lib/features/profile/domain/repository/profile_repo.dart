import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/profile_local_repo.dart';
import '../../data/repository/profile_remote_repo.dart';
import '../entity/profile_entity.dart';

final profileRepositoryProvider = Provider<IProfileRepository>(
  (ref) {
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);
    // print("INTERNET-----------");
    // print(internetStatus);
    // return ref.watch(profileRemoteRepoProvider);

    if (internetStatus == ConnectivityStatus.isConnected) {
      print("INTERNET ACCESS");
      // If internet is available then return remote repo
      return ref.watch(profileRemoteRepoProvider);
    } else {
      print("NO INTERNET ACCESS");
      // If internet is not available then return local repo
      return ref.watch(profileLocalRepoProvider);
    }
  },
);

abstract class IProfileRepository {
  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile);
  Future<Either<Failure, List<ProfileEntity>>> getUserDetails();
  Future<Either<Failure, List<ProfileEntity>>> getApplicants(String jobId);

}
