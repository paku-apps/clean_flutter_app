
import 'package:clean_app/data/model/assign_confirm.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/services/dio_services.dart';

abstract class SupervisorRepository {

  Future<String> registerAuthorization(int idSupervisor, List<AuthorizationConfirmation> listInasistencias);

}

class SupervisorRepositoryImpl extends SupervisorRepository {

  @override
  Future<String> registerAuthorization(int idSupervisor, List<AuthorizationConfirmation> listInasistencias ) async {
    HttpDioService httpService = HttpDioService();
    httpService.init();

    var pathService = pathServer+stage+registerAuthCharger;    
    
    try {
      var response = await httpService.request(
        method: Method.POST,
        url: pathService,
        params: {
          "id_supervisor": idSupervisor,
          "estudiantes": authConfirmationToJson(listInasistencias)
        }
      );
      if(response.statusCode == 200){

        var apiResultResponse =  ApiResultResponse.fromJson(response.data);
        return "SUCCESS";

      } else {
        throw SupervisorRepositoryException(message: 'Error en el repositorio del Supervisor');
      }
    } catch (e){
      throw SupervisorRepositoryException(message: 'Error en el repositorio del Supervisor');
    }
  }

}


class SupervisorRepositoryException implements Exception {
  final String message;

  SupervisorRepositoryException({this.message = 'Error en el repositorio del Supervisor'});
}