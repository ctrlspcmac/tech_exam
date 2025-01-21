import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_request.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_response.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';
import 'package:maya_tech_exam/states/send_money_bloc/send_money_bloc.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements UserRepository {}

void main() {
  late MockRepository repository;
  late SendMoneyBloc bloc;

  setUp(() {
    repository = MockRepository();
    bloc = SendMoneyBloc(repository);
  });

  tearDown(() {
    bloc.close();
  });

  group('Check SendMoneyBloc', () {
    final testResponse = GenericResponse(
        200, "success", [], SendMoneyResponse("1234", "01/01/2025"));
    final testResponseFailed =
        GenericResponse(400, "failed", [], SendMoneyResponse("", ""));
    final testRequest = SendReceiveMoneyRequest(
        receiverAccountId: "1234",
        senderAccountId: "4567",
        amount: "100",
        transactionDate: "2025-01-17 14:20:35",
        currency: "PHP",
        transactionType: "SEND");

    blocTest(
      'when fail request',
      setUp: () {
        when(repository.sendMoney(request: testRequest))
            .thenAnswer((_) async => testResponseFailed);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(SendMoneyRequired(body: testRequest)),
      expect: () => [
        isA<SendMoneyState>().having((state) => state.status, 'status',
            SendMoneyStatus.loading), // Expect loading first
        isA<SendMoneyState>().having((state) => state.status, 'status',
            SendMoneyStatus.failure), // Then failure
      ],
      verify: (bloc) {
        expect(bloc.state.status, SendMoneyStatus.failure);
      },
    );

    blocTest(
      'when success request',
      setUp: () {
        when(repository.sendMoney(request: testRequest))
            .thenAnswer((_) async => Future.value(testResponse));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(SendMoneyRequired(body: testRequest)),
      expect: () => [
        isA<SendMoneyState>().having((state) => state.status, 'status',
            SendMoneyStatus.loading), // Expect loading first
        isA<SendMoneyState>().having((state) => state.status, 'status',
            SendMoneyStatus.success), // Then success
      ],
      verify: (bloc) {
        expect(bloc.state.body?.id, "1234");
      },
    );
  });
}
