    LogOutput,
    Constants::LOGAPP},
    Constants::ANNOTATEAPP},
    Constants::DIFFAPP}
    menu->setTitle(tr("Me&rcurial"));
    int currentLine = -1;
    if (Core::IEditor *editor = Core::EditorManager::currentEditor())
        currentLine = editor->currentLine();
    m_client->annotate(state.currentFileTopLevel(), state.relativeCurrentFile(), QString(), currentLine);
                                                            Constants::COMMIT_ID);
    MercurialEditor editor(editorParameters + 2, 0);
    MercurialEditor editor(editorParameters, 0);