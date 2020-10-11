#include "filesystemmodel.h"
#include <QTimer>
#include <QDir>
#include <iostream>

FileSystemModel::FileSystemModel(QObject * parent, const QString& root)
{
    this->root = root;
    this->currentRoot = root;

    fileSystemWatcher.addPath(root);

    populate();
    connect(&fileSystemWatcher, SIGNAL(directoryChanged(const QString &)), this, SLOT(directoryChanged(const QString &)));
}

int FileSystemModel::rowCount(const QModelIndex& parent) const
{
   return mDatas.size();
}

int FileSystemModel::columnCount(const QModelIndex& parent) const
{
   return 1;
}

QVariant FileSystemModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role) {
    case Qt::DisplayRole:
    case FileNameRole:
        return mDatas.at(index.row()).fileName();
    case FullPathRole:
        return mDatas.at(index.row()).absoluteFilePath();
    case IsDirRole:
        return mDatas.at(index.row()).isDir();
    }

    return QVariant();
}

QHash<int, QByteArray> FileSystemModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[FileNameRole] = "fileName";
    names[FullPathRole] = "path";
    names[IsDirRole] = "isDir";
    return names;
}

void FileSystemModel::directoryChanged(const QString& newValue) {
   populate();
}

void FileSystemModel::populate()
{
    beginResetModel();
    mDatas.clear();
    QDir dir(fileSystemWatcher.directories().first());
    for (QString directory:dir.entryList(QDir::AllEntries | QDir::NoDot | QDir::NoSymLinks)) {
        if (currentRoot == root && directory == "..") continue;
        mDatas.append(QFileInfo(QFile(currentRoot + "/" + directory)));
    }
    endResetModel();
}

Q_INVOKABLE void FileSystemModel::select(const QString &path) {
    std::cout << path.toStdString() << std::endl;
    currentRoot = path;
    fileSystemWatcher.removePaths(fileSystemWatcher.directories());
    fileSystemWatcher.addPath(currentRoot);
    populate();

}
