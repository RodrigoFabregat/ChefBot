import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/admob_util.dart' as admob;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'lista_de_chats_model.dart';
export 'lista_de_chats_model.dart';

class ListaDeChatsWidget extends StatefulWidget {
  const ListaDeChatsWidget({Key? key}) : super(key: key);

  @override
  _ListaDeChatsWidgetState createState() => _ListaDeChatsWidgetState();
}

class _ListaDeChatsWidgetState extends State<ListaDeChatsWidget>
    with TickerProviderStateMixin {
  late ListaDeChatsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'iconButtonOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 460.ms,
          begin: Offset(3, 3),
          end: Offset(1, 1),
        ),
      ],
    ),
    'iconButtonOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 550.ms,
          begin: Offset(3, 3),
          end: Offset(1, 1),
        ),
      ],
    ),
    'textOnPageLoadAnimation': AnimationInfo(
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
    'listViewOnPageLoadAnimation': AnimationInfo(
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
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListaDeChatsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setDarkModeSetting(context, ThemeMode.light);
    });
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

    return StreamBuilder<List<ChatRecord>>(
      stream: queryChatRecord(
        queryBuilder: (chatRecord) => chatRecord
            .where(
              'creador',
              isEqualTo: currentUserReference,
            )
            .orderBy('date', descending: true),
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
        List<ChatRecord> listaDeChatsChatRecordList = snapshot.data!;
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
              title: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Lista de chats',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 22,
                        ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation']!),
                ],
              ),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.white,
                        borderRadius: 20,
                        borderWidth: 1,
                        buttonSize: 40,
                        fillColor: Color(0x4C000000),
                        icon: Icon(
                          Icons.add_box,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          size: 24,
                        ),
                        onPressed: () async {
                          var chatRecordReference = ChatRecord.collection.doc();
                          await chatRecordReference.set(createChatRecordData(
                            creador: currentUserReference,
                            date: getCurrentTimestamp,
                          ));
                          _model.nuevoChat = ChatRecord.getDocumentFromData(
                              createChatRecordData(
                                creador: currentUserReference,
                                date: getCurrentTimestamp,
                              ),
                              chatRecordReference);

                          context.pushNamed(
                            'DetallesDeChat',
                            queryParameters: {
                              'chat': serializeParam(
                                _model.nuevoChat,
                                ParamType.Document,
                              ),
                            }.withoutNulls,
                            extra: <String, dynamic>{
                              'chat': _model.nuevoChat,
                            },
                          );

                          setState(() {});
                        },
                      ).animateOnPageLoad(
                          animationsMap['iconButtonOnPageLoadAnimation1']!),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.white,
                        borderRadius: 20,
                        borderWidth: 1,
                        buttonSize: 40,
                        fillColor: Color(0x4C000000),
                        icon: Icon(
                          Icons.logout,
                          color: Color(0xFF9D050F),
                          size: 24,
                        ),
                        onPressed: () async {
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          context.goNamedAuth('Login', context.mounted);
                        },
                      ).animateOnPageLoad(
                          animationsMap['iconButtonOnPageLoadAnimation2']!),
                    ),
                  ],
                ),
              ],
              centerTitle: false,
              elevation: 2,
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                                child: Builder(
                                  builder: (context) {
                                    final misChats =
                                        listaDeChatsChatRecordList.toList();
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: misChats.length,
                                      itemBuilder: (context, misChatsIndex) {
                                        final misChatsItem =
                                            misChats[misChatsIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            admob.loadInterstitialAd(
                                              "",
                                              "ca-app-pub-465238",
                                              true,
                                            );

                                            _model.interstitialAdSuccess =
                                                await admob
                                                    .showInterstitialAd();

                                            context.pushNamed(
                                              'DetallesDeChat',
                                              queryParameters: {
                                                'chat': serializeParam(
                                                  misChatsItem,
                                                  ParamType.Document,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'chat': misChatsItem,
                                              },
                                            );

                                            setState(() {});
                                          },
                                          child: Slidable(
                                            endActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              extentRatio: 0.25,
                                              children: [
                                                SlidableAction(
                                                  label: 'Eliminar',
                                                  backgroundColor:
                                                      Color(0xFFB15959),
                                                  icon: FontAwesomeIcons
                                                      .solidTrashAlt,
                                                  onPressed: (_) async {
                                                    var confirmDialogResponse =
                                                        await showDialog<bool>(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Confirmar'),
                                                                  content: Text(
                                                                      '¿Deseas eliminar este chat?'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                      child: Text(
                                                                          'Cancelar'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          true),
                                                                      child: Text(
                                                                          'Confirmar'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ) ??
                                                            false;
                                                    if (confirmDialogResponse) {
                                                      await misChatsItem
                                                          .reference
                                                          .delete();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'El chat fue eliminador',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBtnText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  2000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                misChatsItem.ultimoMensaje
                                                    .maybeHandleOverflow(
                                                        maxChars: 35),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium,
                                              ),
                                              subtitle: Text(
                                                dateTimeFormat('relative',
                                                    misChatsItem.date!),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                              ),
                                              trailing: Icon(
                                                Icons.arrow_forward_ios,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 20,
                                              ),
                                              tileColor: Color(0xFF032757),
                                              dense: false,
                                            ),
                                          ),
                                        );
                                      },
                                    ).animateOnPageLoad(animationsMap[
                                        'listViewOnPageLoadAnimation']!);
                                  },
                                ),
                              ),
                            ],
                          ),
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
                                showsTestAd: false,
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
