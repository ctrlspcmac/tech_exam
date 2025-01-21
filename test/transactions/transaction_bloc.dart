import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/transactions/transactions_response.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';
import 'package:maya_tech_exam/states/transactions/transactions_bloc.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements UserRepository {}

void main() {
  late MockRepository repository;
  late TransactionsBloc bloc;

  setUp(() {
    repository = MockRepository();
    bloc = TransactionsBloc(repository);
  });

  tearDown(() {
    bloc.close();
  });

  group('Check TransactionsBloc', () {
    final testResponse = GenericResponse(
        200, "success", [], ([
      TransactionsResponse("1","123","1","400.00","2025-01-17 14:20:35","PHP","SEND")
    ])
    );

    final testResponseFailed = GenericResponse(
        400, "failed", [], [TransactionsResponse()]
    );



    blocTest('when fail request',
      setUp: () {
        when(repository.getAllTransactions(request: "1"))
            .thenAnswer((_) async => testResponseFailed);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTransactions(body: "1")),
      expect: () => [
        isA<TransactionsState>().having((state) => state.status, 'status', TransactionsStatus.loading),
        isA<TransactionsState>().having((state) => state.status, 'status', TransactionsStatus.failure),
      ],
      verify: (bloc) {
        expect(bloc.state.status, TransactionsStatus.failure);
      },
    );

    blocTest('when success request',
      setUp: () {
        when(repository.getAllTransactions(request: "1"))
            .thenAnswer((_) async => Future.value(testResponse));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTransactions(body: "1")),
      expect: () => [
        isA<TransactionsState>().having((state) => state.status, 'status', TransactionsStatus.loading),
        isA<TransactionsState>().having((state) => state.status, 'status', TransactionsStatus.success),
      ],
      verify: (bloc) {
        expect(bloc.state.body?[0].amount ?? "", "400.00");
      },
    );
  });
}

