import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'detalles_de_chat_model.dart';
export 'detalles_de_chat_model.dart';

class DetallesDeChatWidget extends StatefulWidget {
  const DetallesDeChatWidget({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final ChatRecord? chat;

  @override
  _DetallesDeChatWidgetState createState() => _DetallesDeChatWidgetState();
}

class _DetallesDeChatWidgetState extends State<DetallesDeChatWidget>
    with TickerProviderStateMixin {
  late DetallesDeChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasIconTriggered = false;
  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 330.ms,
          begin: Offset(2, 2),
          end: Offset(1, 1),
        ),
      ],
    ),
    'iconButtonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 330.ms,
          begin: Offset(3, 3),
          end: Offset(1, 1),
        ),
      ],
    ),
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 330.ms,
          begin: Offset(3, 3),
          end: Offset(1, 1),
        ),
      ],
    ),
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(3, 3),
          end: Offset(1, 1),
        ),
      ],
    ),
    'iconOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        RotateEffect(
          curve: Curves.linear,
          delay: 0.ms,
          duration: 2000.ms,
          begin: -5,
          end: 0,
        ),
        RotateEffect(
          curve: Curves.linear,
          delay: 2000.ms,
          duration: 2000.ms,
          begin: -5,
          end: 0,
        ),
        RotateEffect(
          curve: Curves.linear,
          delay: 4000.ms,
          duration: 2000.ms,
          begin: -5,
          end: 0,
        ),
        RotateEffect(
          curve: Curves.linear,
          delay: 6000.ms,
          duration: 2000.ms,
          begin: -5,
          end: 0,
        ),
        RotateEffect(
          curve: Curves.linear,
          delay: 8000.ms,
          duration: 2000.ms,
          begin: -5,
          end: 0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetallesDeChatModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return StreamBuilder<List<MensajeRecord>>(
      stream: queryMensajeRecord(
        parent: widget.chat?.reference,
        queryBuilder: (mensajeRecord) => mensajeRecord.orderBy('fecha'),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF032757),
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<MensajeRecord> detallesDeChatMensajeRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFF032757),
            appBar: AppBar(
              backgroundColor: Color(0xFF7C5AF1),
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  context.pop();
                },
              ).animateOnPageLoad(
                  animationsMap['iconButtonOnPageLoadAnimation']!),
              title: Text(
                'Chef BOT',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22,
                    ),
              ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
              actions: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://i.ibb.co/BtNKn0Y/logopeque.png',
                    width: 150,
                    height: 360,
                    fit: BoxFit.contain,
                  ),
                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
              ],
              centerTitle: false,
              elevation: 4,
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/fondoooo.jpg',
                        ).image,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      if (responsiveVisibility(
                        context: context,
                        tabletLandscape: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 8, 60),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            final listaMensajes =
                                                detallesDeChatMensajeRecordList
                                                    .toList();
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: listaMensajes.length,
                                              itemBuilder: (context,
                                                  listaMensajesIndex) {
                                                final listaMensajesItem =
                                                    listaMensajes[
                                                        listaMensajesIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (!listaMensajesItem
                                                        .esUsuario)
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.00, 0.00),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 4),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 4,
                                                                  color: Color(
                                                                      0xD5000000),
                                                                  offset:
                                                                      Offset(
                                                                          0, 2),
                                                                  spreadRadius:
                                                                      0,
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              shape: BoxShape
                                                                  .rectangle,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          4,
                                                                          16,
                                                                          4),
                                                              child: Text(
                                                                listaMensajesItem
                                                                    .texto,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (listaMensajesItem
                                                        .esUsuario)
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.00, 0.00),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 4),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF41317F),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 4,
                                                                  color: Color(
                                                                      0xD5000000),
                                                                  offset:
                                                                      Offset(
                                                                          0, 2),
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          4,
                                                                          16,
                                                                          4),
                                                              child: Text(
                                                                listaMensajesItem
                                                                    .texto,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (responsiveVisibility(
                                context: context,
                                tabletLandscape: false,
                              ))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Container(
                                    width: 330,
                                    decoration: BoxDecoration(
                                      color: Color(0xD5323030),
                                      borderRadius: BorderRadius.circular(50),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 8, 0),
                                            child: TextFormField(
                                              controller: _model.textController,
                                              focusNode:
                                                  _model.textFieldFocusNode,
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Escribe algo...',
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBtnText,
                                                    ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBtnText,
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF1D2428),
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBtnText,
                                                  ),
                                              validator: _model
                                                  .textControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (animationsMap[
                                                      'iconOnActionTriggerAnimation'] !=
                                                  null) {
                                                setState(() =>
                                                    hasIconTriggered = true);
                                                SchedulerBinding.instance
                                                    .addPostFrameCallback(
                                                        (_) async =>
                                                            await animationsMap[
                                                                    'iconOnActionTriggerAnimation']!
                                                                .controller
                                                                .forward(
                                                                    from: 0.0));
                                              }

                                              await MensajeRecord.createDoc(
                                                      widget.chat!.reference)
                                                  .set(createMensajeRecordData(
                                                texto:
                                                    _model.textController.text,
                                                fecha: getCurrentTimestamp,
                                                esUsuario: true,
                                              ));
                                              _model.apiResult6g3 =
                                                  await ChefGPTmensajeCall.call(
                                                aPIKey:
                                                    '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',
                                                mensaje: getJsonField(
                                                  functions.formatarMensaje(
                                                      detallesDeChatMensajeRecordList
                                                          .toList(),
                                                      _model
                                                          .textController.text),
                                                  r'''$''',
                                                ).toString(),
                                              );
                                              if ((_model.apiResult6g3
                                                      ?.succeeded ??
                                                  true)) {
                                                await MensajeRecord.createDoc(
                                                        widget.chat!.reference)
                                                    .set(
                                                        createMensajeRecordData(
                                                  texto: ChefGPTmensajeCall
                                                      .contenido(
                                                    (_model.apiResult6g3
                                                            ?.jsonBody ??
                                                        ''),
                                                  ).toString(),
                                                  fecha: getCurrentTimestamp,
                                                  esUsuario: false,
                                                ));

                                                await widget.chat!.reference
                                                    .update(
                                                        createChatRecordData(
                                                  date: getCurrentTimestamp,
                                                  ultimoMensaje:
                                                      ChefGPTmensajeCall
                                                          .contenido(
                                                    (_model.apiResult6g3
                                                            ?.jsonBody ??
                                                        ''),
                                                  ).toString(),
                                                ));
                                                setState(() {
                                                  _model.textController
                                                      ?.clear();
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      (_model.apiResult6g3
                                                                  ?.jsonBody ??
                                                              '')
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFA33E3E),
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }

                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.send_rounded,
                                              color: Color(0xFF4C82FB),
                                              size: 24,
                                            ),
                                          ).animateOnActionTrigger(
                                              animationsMap[
                                                  'iconOnActionTriggerAnimation']!,
                                              hasBeenTriggered:
                                                  hasIconTriggered),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ).animateOnPageLoad(
                              animationsMap['columnOnPageLoadAnimation']!),
                        ),
                      Align(
                        alignment: AlignmentDirectional(0.00, 1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Container(
                            width: 393,
                            height: 50,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 1.00),
                              child: FlutterFlowAdBanner(
                                height: 50,
                                showsTestAd: true,
                                androidAdUnitID: 'ca-app-pub-465238',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
