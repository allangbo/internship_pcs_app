import 'package:flutter/material.dart';

class PublishVacancyFourthForm extends StatefulWidget {
  const PublishVacancyFourthForm({Key? key}) : super(key: key);

  @override
  State<PublishVacancyFourthForm> createState() =>
      PublishVacancyFourthFormState();
}

class PublishVacancyFourthFormState extends State<PublishVacancyFourthForm> {
  List<String> steps = ['Etapa 1', 'Etapa 2', 'Etapa 3'];

  void _showAddStepDialog() {
    String newStep = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Etapa'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newStep = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                setState(() {
                  steps.add(newStep);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// Função para remover etapas
  void _removeStep(int index) {
    setState(() {
      steps.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _showAddStepDialog();
          },
          child: const Text('Adicionar Etapa'),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ReorderableListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final String item = steps.removeAt(oldIndex);
                steps.insert(newIndex, item);
              });
            },
            children: List.generate(steps.length, (index) {
              return ListTile(
                  key: Key('$index Step ${index + 1}'),
                  title: Text(steps[index]),
                  leading: const Icon(Icons.drag_handle),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _removeStep(index);
                    },
                  ));
            }),
          ),
        ),
      ],
    );
  }
}
