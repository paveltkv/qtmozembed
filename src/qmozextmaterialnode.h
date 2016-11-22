/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#ifndef qMozExtMaterialNode_h
#define qMozExtMaterialNode_h

#include <QtQuick/QSGGeometryNode>
#include <QObject>

class MozExtMaterialNode : public QObject, public QSGGeometryNode
{
    Q_OBJECT
public:
    MozExtMaterialNode();

    ~MozExtMaterialNode() {}

    void update();

public Q_SLOTS:

    // This function gets called on the FBO rendering thread and will store the
    // texture id and size and schedule an update on the window.
    void newTexture(int id, const QRectF &bounds, int orientation);

    // Before the scene graph starts to render, we update to the pending texture
    void prepareNode();

private:
    void updateGeometry(const QRectF &rect, Qt::ScreenOrientation orientation);

    int m_id;
    QRectF m_bounds;
    Qt::ScreenOrientation m_orientation;
};

#endif /* qMozExtMaterialNode_h */
