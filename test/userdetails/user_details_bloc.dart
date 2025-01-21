import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/user_details/user_details.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';
import 'package:maya_tech_exam/states/user_details/user_details_bloc.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements UserRepository {}

void main() {
  late MockRepository repository;
  late UserDetailsBloc bloc;

  setUp(() {
    repository = MockRepository();
    bloc = UserDetailsBloc(repository);
  });

  tearDown(() {
    bloc.close();
  });

  group('Check UserDetailsBloc', () {
    final testResponse = GenericResponse(
        200, "success", [], UserDetails("1", "jay garcia", "500"));

    final testResponseFailed =
        GenericResponse(400, "failed", [], UserDetails());

    blocTest(
      'when get user details fail  ',
      setUp: () {
        when(repository.getUserDetails(request: "1"))
            .thenAnswer((_) async => testResponseFailed);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetUserDetails(body: "1")),
      expect: () => [
        isA<UserDetailsState>().having(
            (state) => state.status, 'status', UserDetailsStatus.loading),
        isA<UserDetailsState>().having(
            (state) => state.status, 'status', UserDetailsStatus.failure),
      ],
      verify: (bloc) {
        expect(bloc.state.status, UserDetailsStatus.failure);
      },
    );

    blocTest(
      'when get user details success',
      setUp: () {
        when(repository.getUserDetails(request: "1"))
            .thenAnswer((_) async => Future.value(testResponse));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetUserDetails(body: "1")),
      expect: () => [
        isA<UserDetailsState>().having(
            (state) => state.status, 'status', UserDetailsStatus.loading),
        isA<UserDetailsState>().having(
            (state) => state.status, 'status', UserDetailsStatus.success),
      ],
      verify: (bloc) {
        expect(bloc.state.body?.balance ?? "", "500");
      },
    );
  });

  group('Check update Balance', () {
    final testUpdateResponse = GenericResponse(
        200, "success", [], UserDetails("1", "jay garcia", "2500"));

    final testUpdateResponseFailed =
        GenericResponse(400, "failed", [], UserDetails());

    var request = UserDetails("1", "Name", "2500");
    blocTest(
      'when update balance fail  ',
      setUp: () {
        when(repository.updateBalance(request: request))
            .thenAnswer((_) async => testUpdateResponseFailed);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(UpdateBalance(body: request)),
      expect: () => [
        isA<UserDetailsState>().having(
            (state) => state.status, 'status', UserDetailsStatus.loading),
        isA<UserDetailsState>().having(
            (state) => state.status, 'status', UserDetailsStatus.failure),
      ],
      verify: (bloc) {
        expect(bloc.state.status, UserDetailsStatus.failure);
      },
    );

    blocTest(
      'when update balance success',
      setUp: () {
        when(repository.updateBalance(request: request))
            .thenAnswer((_) async => Future.value(testUpdateResponse));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(UpdateBalance(body: request)),
      expect: () => [
        isA<UserDetailsState>().having(
            (state) => state.status, 'status', UserDetailsStatus.loading),
        isA<UserDetailsState>().having(
            (state) => state.status, 'status', UserDetailsStatus.success),
      ],
      verify: (bloc) {
        expect(bloc.state.body?.balance ?? "", "2500");
      },
    );
  });
}
