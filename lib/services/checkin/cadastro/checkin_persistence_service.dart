import 'dart:typed_data';

import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';

class CheckinPersistenceService {
  final GenericRepository<Checkin> repository;

  CheckinPersistenceService({required this.repository});

  Future<Checkin> createCheckin({
    required Checkin checkin,
    Uint8List? criancaImage,
    Uint8List? responsavelEntradaImage,
  }) async {
    final createdCheckin = await repository.create(checkin.toJson());

    if (responsavelEntradaImage != null) {
      await repository.uploadFile(
        pathField: 'checkin_responsavel',
        filename: '${checkin.responsavelEntrada?.id}_${createdCheckin.id}.png',
        fileBytes: responsavelEntradaImage,
      );
    }

    if (criancaImage != null) {
      await repository.uploadFile(
        pathField: 'checkin_crianca',
        filename: '${checkin.crianca?.id}_${createdCheckin.id}.png',
        fileBytes: criancaImage,
      );
    }

    return createdCheckin;
  }

  Future<void> updateCheckin({
    required Checkin checkin,
    Uint8List? responsavelSaidaImage,
  }) async {
    await repository.update(checkin.id, checkin.toJson());

    if (responsavelSaidaImage != null) {
      await repository.uploadFile(
        pathField: 'checkout_responsavel',
        filename: '${checkin.responsavelSaida?.id}_${checkin.id}.png',
        fileBytes: responsavelSaidaImage,
      );
    }
  }
}