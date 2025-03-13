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

type NodeId is uint256;

interface INodes {

    struct Node {
        NodeId id;
        uint256 port;
        bytes ip;
        address nodeAddress;
        bytes32[2] nodePublicKey;
    }

    event NodeRegistered(NodeId indexed nodeId, address indexed nodeAddress, bytes ip, uint256 port);

    function registerNode(
        bytes calldata ip,
        uint256 port
    ) external;

    function registerPassiveNode(
        bytes calldata ip,
        uint256 port
    ) external;

    function getNode(NodeId nodeId) external view returns (Node memory node);
}
