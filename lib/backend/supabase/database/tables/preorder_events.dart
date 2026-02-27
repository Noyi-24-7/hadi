import '../database.dart';

class PreorderEventsTable extends SupabaseTable<PreorderEventsRow> {
  @override
  String get tableName => 'preorder_events';

  @override
  PreorderEventsRow createRow(Map<String, dynamic> data) =>
      PreorderEventsRow(data);
}

class PreorderEventsRow extends SupabaseDataRow {
  PreorderEventsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PreorderEventsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get preorderRequestId => getField<String>('preorder_request_id')!;
  set preorderRequestId(String value) =>
      setField<String>('preorder_request_id', value);

  String get eventType => getField<String>('event_type')!;
  set eventType(String value) => setField<String>('event_type', value);

  DateTime get eventAt => getField<DateTime>('event_at')!;
  set eventAt(DateTime value) => setField<DateTime>('event_at', value);

  dynamic get payload => getField<dynamic>('payload')!;
  set payload(dynamic value) => setField<dynamic>('payload', value);
}
