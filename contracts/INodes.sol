// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   INodes.sol - playa-manager
 *   Copyright (C) 2025-Present SKALE Labs
 *   @author Dmytro Stebaiev
 *
 *   playa-manager is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   playa-manager is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with playa-manager.  If not, see <https://www.gnu.org/licenses/>.
 */

pragma solidity ^0.8.24;

import { ICommittee } from "./ICommittee.sol";

type NodeId is uint256;

using {
    _nodeIdEquals as ==
} for NodeId global;

interface INodes {

    struct Node {
        NodeId id;
        bytes ip;
        string domainName;
        address nodeAddress;
        uint16 port;
    }

    event NodeRegistered(NodeId indexed nodeId, address indexed nodeAddress, bytes ip, uint16 port);
    event NodeAddressChanged(NodeId indexed nodeId, address indexed oldAddress, address indexed newAddress);
    event NodeDomainNameChanged(NodeId indexed nodeId, address indexed nodeAddress, string newName);
    event NodeIpChanged(NodeId indexed nodeId, address indexed nodeAddress, bytes ip, uint16 port);

    function initialize(address initialAuthority, Node[] calldata initialNodes) external;
    function setCommittee(ICommittee committeeAddress) external;
    function registerNode(
        bytes calldata ip,
        uint16 port
    ) external;
    function registerPassiveNode(
        bytes calldata ip,
        uint16 port
    ) external;

    function setIpAddress(NodeId nodeId, bytes calldata ip, uint16 port) external;
    function setDomainName(NodeId nodeId, string calldata name) external;
    function requestChangeAddress(NodeId nodeId, address newAddress) external;
    function confirmAddressChange(NodeId nodeId) external;
    function getNode(NodeId nodeId) external view returns (Node memory node);
    function getNodeId(address nodeAddress) external view returns (NodeId nodeId);
    function getPassiveNodeIds(address nodeAddress) external view returns (NodeId[] memory nodeIds);
    function getActiveNodesIds() external view returns (NodeId[] memory nodeIds);
    function activeNodeExists(NodeId nodeId) external view returns (bool result);
}

// Slither flags as unused by interfaces but code is used
// in playa-manager implementation to overload == operant

// slither-disable-start dead-code
function _nodeIdEquals(NodeId a, NodeId b) pure returns (bool result) {
    return NodeId.unwrap(a) == NodeId.unwrap(b);
}
// slither-disable-end dead-code
