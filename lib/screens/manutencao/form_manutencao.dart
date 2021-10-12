import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tcc_apiario/models/manutencao.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tcc_apiario/services/database.dart';
import 'package:tcc_apiario/shared/constants.dart';

class FormManutencao extends StatefulWidget {
  final Manutencao? manutencao;
  final String? keyCaixa;
  FormManutencao({ this.manutencao, this.keyCaixa });

  @override
  _FormManutencaoState createState() => _FormManutencaoState();
}

class _FormManutencaoState extends State<FormManutencao> {
  final DateRangePickerController _dateRangePickerController = DateRangePickerController();
  DateTime dataManutencaoPicker = DateTime.now();
  String descricao = '';

  final _descricaoController = TextEditingController();

  @override
  void initState() {
    if (widget.manutencao != null) {
      _descricaoController.text = widget.manutencao!.descricao;
      descricao = widget.manutencao!.descricao;
      _dateRangePickerController.selectedDate = widget.manutencao!.dataManutencao.toDate();
      dataManutencaoPicker = widget.manutencao!.dataManutencao.toDate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Manutenção'),
        backgroundColor: Color(0xFFCF5C36),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Data da Manutenção: ', style: TextStyle(fontSize: 16.0),),
              ),
              SizedBox(
                height: 8.0,
              ),
              SfDateRangePicker(
                controller: _dateRangePickerController,
                initialSelectedDate: dataManutencaoPicker,
                view: DateRangePickerView.month,
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Descrição: ', style: TextStyle(fontSize: 16.0),),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: _descricaoController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) => value!.isEmpty ? 'Digite a descrição da manutenção...' : null,
                onChanged: (value) {
                  setState(() {
                    descricao = value;
                  });
                },
                decoration: textInputDecoration.copyWith(hintText: 'Descrição'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFFCF5C36)),
                ),
                child: Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                    if (descricao.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Digite a descrição...')
                        )
                      );
                    } else {
                      if (widget.manutencao == null) {
                        await DatabaseService().addManutencao(descricao, Timestamp.fromDate(dataManutencaoPicker), widget.keyCaixa!);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Manutenção Cadastrada')
                            )
                        );
                      } else {
                        await DatabaseService().updateManutencao(widget.manutencao!.keyManutencao, descricao, Timestamp.fromDate(dataManutencaoPicker));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Manutenção Editada')
                            )
                        );
                      }
                    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        dataManutencaoPicker = args.value;
      });
    });
  }
}
