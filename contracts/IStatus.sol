// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   IStatus.sol - playa-manager
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

import {INodes, NodeId} from "./INodes.sol";

type Duration is uint256;

interface IStatus {

    event HeartbeatIntervalChanged(Duration interval);
    event HeartbeatSignal(NodeId indexed nodeId, uint256 timestamp);

    function initialize(address initialAuthority, INodes nodesAddress) external;
    function alive() external;
    function setHeartbeatInterval(Duration interval) external;
    function whitelistNode(NodeId nodeId) external;
    function removeNodeFromWhitelist(NodeId nodeId) external;
    function isHealthy(NodeId nodeId) external view returns (bool healthy);
    function getNodesEligibleForCommittee() external view returns (NodeId[] memory nodeIds);
    function getWhitelistedNodes() external view returns (NodeId[] memory nodeIds);
    function isWhitelisted(NodeId nodeId) external view returns (bool whitelisted);
}
