import 'package:crud/blocs/notes_events.dart';
import 'package:crud/blocs/notes_state.dart';
import 'package:crud/firestore_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NotesEvents, NotesState>{
  final FirestoreServices firestoreServices;

  NotesBloc({required this.firestoreServices}):super(WriteNotesInitial()){
    on<WriteNotes>((event, emit) async{
      emit(WriteNotesLoading());
      final response= await firestoreServices.writeNote(event.note);
      response.fold(
          (l)=> emit(WriteNotesFailed()),
          (r)=>emit(WriteNotesSuccess())
      );
    });
  }
}