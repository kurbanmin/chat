//
//  MultipeerCommunicator.swift
//  Chat
//
//  Created by Qurban on 15/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class MultipeerCommunicator: NSObject, Communicator {
    weak var delegate: CommunicatorDelegate?
    
    var online: Bool = false
    
    var myPeerID: MCPeerID!
    
    var browcer: MCNearbyServiceBrowser!
    var advertiser: MCNearbyServiceAdvertiser!
    
    var sessions: [MCSession] = []
    var users: [ConversationUser] = []
    
    override init() {
        super.init()
        myPeerID = MCPeerID(displayName: UIDevice.current.name)
        
        browcer = MCNearbyServiceBrowser(peer: myPeerID, serviceType: "tinkoff-chat")
        browcer.delegate = self
        browcer.startBrowsingForPeers()
        
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: ["userName" : "Kurban"], serviceType: "tinkoff-chat")
        advertiser.delegate = self
        advertiser.startAdvertisingPeer()
    }
    
    func sendMessage(string: String, to userID: String, completionHandler: ((Bool, Error?) -> ())?) {
        if let session = sessions.filter({ $0.connectedPeers.map({ $0.displayName }).contains(userID) }).first {
            let communicationMessage = CommunicationMessage(text: string)
            
            do {
                let data = try JSONEncoder().encode(communicationMessage)
                try session.send(data, toPeers: session.connectedPeers, with: .reliable)
                completionHandler?(true, nil)
            } catch {
                completionHandler?(false, error)
            }
        }
    }
}

extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        if let userName = info?["userName"]  {
            let conversationUser = ConversationUser(peerID: peerID, userName: userName)
            users.append(conversationUser)
            
            let session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
            session.delegate = self
            sessions.append(session)
            browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.didLostUser(userID: peerID.displayName)
        if let sessionIndex = sessions.firstIndex(where: { $0.connectedPeers.contains(peerID) }) {
            sessions.remove(at: sessionIndex)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        delegate?.failedToStartBrowsing(error: error)
    }
}

extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        if let session = sessions.filter({ $0.connectedPeers.contains(peerID) }).first {
            invitationHandler(false, session)
        } else {
            let session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
            session.delegate = self
            sessions.append(session)
            invitationHandler(true, session)
        }
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        delegate?.failedToStartAdvertising(error: error)
    }
}

extension MultipeerCommunicator: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            if let user = users.filter({ $0.peerID.displayName == peerID.displayName  }).first {
                delegate?.didFoundUser(userID: user.peerID.displayName, userName: user.userName)
            }
        case .connecting:
            break
        case .notConnected:
            
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let communicationMessage = try? JSONDecoder().decode(CommunicationMessage.self, from: data) {
            delegate?.didRecieveMessage(text: communicationMessage.text, fromUser: peerID.displayName, to: myPeerID.displayName)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}
