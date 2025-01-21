import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/login/usercred_data.dart';
import 'package:maya_tech_exam/domains/datasource/models/login/userinfo_data.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';
import 'package:maya_tech_exam/states/sign_in_bloc/sign_in_bloc.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements UserRepository {}
void main() {
  late MockRepository repository;
  late SignInBloc bloc;

  setUp(() {
    repository = MockRepository();
    bloc = SignInBloc(repository);
  });

  tearDown(() {
    bloc.close();
  });

  group('Check SignIn Bloc', () {
    final testResponse = GenericResponse(
        200, "Logged in success", [], UserInfoModel("usernameTest", "fName", "lName"));
    final testResponseFailed = GenericResponse(
        400, "Logged in failed", [], UserInfoModel("", "", ""));
    final testRequest = UserCredentialsModel("usernameTest", "passwordTest");

    blocTest('when fail request',
      setUp: () {
        when(repository.signIn(request: testRequest))
            .thenAnswer((_) async => testResponseFailed);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(SignInRequired(body: testRequest)),
      expect: () => [
        isA<SignInState>().having((state) => state.status, 'status', SignInStatus.loading),
        isA<SignInState>().having((state) => state.status, 'status', SignInStatus.failure),
      ],
      verify: (bloc) {
        expect(bloc.state.status, SignInStatus.failure);
      },
    );

    blocTest('when success request',
      setUp: () {
        when(repository.signIn(request: testRequest))
            .thenAnswer((_) async => Future.value(testResponse));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(SignInRequired(body: testRequest)),
      expect: () => [
        isA<SignInState>().having((state) => state.status, 'status', SignInStatus.loading),
        isA<SignInState>().having((state) => state.status, 'status', SignInStatus.success),
      ],
      verify: (bloc) {
        expect(bloc.state.body?.userName, "usernameTest");
      },
    );
  });
}

