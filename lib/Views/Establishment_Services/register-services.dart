import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:iservice_application/Models/service.dart';
import 'package:iservice_application/Models/service_category.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/Utils/DurationSelector.dart';
import 'package:iservice_application/Services/Utils/textFieldUtils.dart';
import 'package:iservice_application/Services/service_services.dart';
import 'package:iservice_application/Views/Establishment_MyEstablishment/catalog.dart';
import '../../Models/Request/service_model.dart';

class RegisterServices extends StatefulWidget {
  final UserInfo userInfo;
  int? selectedDuration;

  RegisterServices({required this.userInfo, this.selectedDuration, Key? key})
      : super(key: key);

  @override
  State<RegisterServices> createState() => _RegisterServicesState();
}

class _RegisterServicesState extends State<RegisterServices> {
  TextEditingController durationController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late double doubleValue;
  int? selectedCategory;
  String mensagemErro = '';
  bool filledFields = false;
  File? _image;
  String? imagePath;
  late String? bytes;
  TimeOfDay? _selectedTime = TimeOfDay.now();
  List<int> durationsInMinutes = List.generate(20, (index) => (index + 1) * 15);
  ServiceServices serviceServices = ServiceServices();
  List<ServiceCategory> serviceCategories = [];

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
        _image = File(pickedImage.path);
      });

      List<int> imageBytes = await pickedImage.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      setState(() {
        bytes = base64Image;
      });
      print(bytes);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedTime = null;
    durationController.addListener(atualizarEstadoCampos);
    serviceNameController.addListener(atualizarEstadoCampos);
    priceController.addListener(atualizarEstadoCampos);
    descriptionController.addListener(atualizarEstadoCampos);

    fetchServiceCategories();
  }

  Future<void> fetchServiceCategories() async {
    try {
      List<ServiceCategory> fetchedCategories =
          await serviceServices.getServicesCategories();
      print(fetchedCategories);
      setState(() {
        serviceCategories = fetchedCategories;
      });
    } catch (e) {
      print('Erro ao buscar as categorias de serviço: $e');
    }
  }

  void atualizarMensagemErro(String mensagem) {
    setState(() {
      mensagemErro = mensagem;
    });
  }

  void atualizarEstadoCampos() {
    setState(() {
      filledFields = serviceNameController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty;
      if (filledFields) {
        atualizarMensagemErro('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF5F6F9),
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
            child: Text(
              "Adicionar um serviço",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.center,
                    ),
                    const SizedBox(height: 10),
                    _image != null
                        ? Container(
                            child: Image.file(
                              _image!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200],
                            ),
                            width: 200,
                            height: 200,
                            child: Icon(Icons.image),
                          ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2864ff),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () =>
                                        _getImage(ImageSource.gallery),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2864ff),
                                    ),
                                    child: Text(
                                      'Escolher imagem da galeria',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _getImage(ImageSource.camera),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2864ff),
                                    ),
                                    child: Text(
                                      'Tirar Foto',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Editar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    //Duração
                    DurationSelector(
                      onDurationSelected: (duration) {
                        setState(() {
                          widget.selectedDuration = duration;
                        });
                      },
                    ),

                    const SizedBox(height: 10),
                    Utils.buildTextField(
                      controller: serviceNameController,
                      hintText: 'Nome do serviço',
                      prefixIcon: Icons.business,
                    ),
                    const SizedBox(height: 10),
                    Utils.buildTextField(
                        controller: priceController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        hintText: 'Preço',
                        prefixIcon: Icons.price_change_outlined,
                        onChanged: (value) {
                          setState(() {
                            doubleValue =
                                double.tryParse(priceController.text) ?? 999999;
                          });
                        }),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      maxLines: null,
                      maxLength: 105,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'Descrição sobre o serviço',
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                        ),
                        prefixIcon: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF2864ff), Color(0xFF2864ff)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Icon(
                            Icons.article_outlined,
                            color: Color(0xFF2864ff),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.5),
                        ),
                      ),
                      onChanged: (value) {
                        if (descriptionController.text.length >= 105) {
                          descriptionController.text =
                              descriptionController.text.substring(0, 105);
                        }
                        atualizarEstadoCampos();
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton<int>(
                        value: selectedCategory,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue ?? 0;
                            mensagemErro = '';
                          });
                        },
                        items: [
                          DropdownMenuItem<int>(
                              value: null,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.category,
                                      color: Color(0xFF2864ff),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Categoria do serviço',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          ...serviceCategories.map<DropdownMenuItem<int>>(
                              (ServiceCategory category) {
                            return DropdownMenuItem<int>(
                              value: category.serviceCategoryId,
                              child: Text(
                                category.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        underline: Container(
                          height: 1.5,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      mensagemErro,
                      style: const TextStyle(color: Colors.red),
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        if (!filledFields) {
                          atualizarMensagemErro(
                              'Por favor, preencha todos os campos.');
                        } else {
                          try {
                            ServiceModel request = ServiceModel(
                              establishmentProfileId: widget.userInfo
                                  .establishmentProfile!.establishmentProfileId,
                              serviceCategoryId: selectedCategory!,
                              name: serviceNameController.text,
                              description: descriptionController.text,
                              price: doubleValue,
                              estimatedDuration: widget.selectedDuration!,
                              imagePath: imagePath,
                            );
                            print(widget.selectedDuration);
                            await ServiceServices()
                                .addService(request)
                                .then((Service service) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Catalog(
                                    userInfo: widget.userInfo,
                                  ),
                                ),
                              );
                            }).catchError((e) {
                              print('Erro ao registrar servidor: $e');
                              atualizarMensagemErro(
                                  'Erro ao registrar servidor: $e');
                            });
                          } catch (error) {
                            atualizarMensagemErro(
                                'Erro ao registrar servidor: $error');
                          }
                        }
                      },
                      color:
                          filledFields ? const Color(0xFF2864ff) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Avançar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
