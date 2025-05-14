// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   IStaking.sol - mirage-manager
 *   Copyright (C) 2025-Present SKALE Labs
 *   @author Dmytro Stebaiev
 *
 *   mirage-manager is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   mirage-manager is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with mirage-manager.  If not, see <https://www.gnu.org/licenses/>.
 */

pragma solidity ^0.8.24;

import {ICommittee} from "./ICommittee.sol";
import {INodes, NodeId} from "./INodes.sol";
import {Playa} from "./units.sol";


interface IStaking {
    receive() external payable;
    function initialize(address initialAuthority, ICommittee committee, INodes nodes) external;
    function stake(NodeId node) external payable;
    function retrieve(NodeId node, Playa value) external;
    function getStakedAmount() external view returns (Playa amount);
    function getStakedAmountFor(address holder) external view returns (Playa amount);
    function getStakedNodes() external view returns (NodeId[] memory nodes);
    function getStakedNodesFor(address holder) external view returns (NodeId[] memory stakedNodes);
    function getStakedToNodeAmount(NodeId node) external view returns (Playa amount);
    function getStakedToNodeAmountFor(NodeId node, address holder) external view returns (Playa amount);
}
