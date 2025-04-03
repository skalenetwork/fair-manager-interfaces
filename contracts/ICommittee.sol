// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   ICommittee.sol - playa-manager
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

import {DkgId, IDkg} from "./IDkg.sol";
import {INodes, NodeId} from "./INodes.sol";
import {IStatus} from "./IStatus.sol";


type CommitteeIndex is uint256;
type Timestamp is uint256;

interface ICommittee {
    struct Committee {
        NodeId[] nodes;
        IDkg.G2Point commonPublicKey;
        Timestamp startingTimestamp;
    }

    function initialize(address initialAuthority, INodes nodesAddress, IStatus statusAddress) external;
    function select() external;
    function processSuccessfulDkg(DkgId dkg) external;
    function newNodeCreated(NodeId nodeId) external;
    function getCommittee(CommitteeIndex committeeIndex) external view returns (Committee memory committee);
    function getActiveCommitteeIndex() external view returns (CommitteeIndex committeeIndex);
    function isNodeInCurrentOrNextCommittee(NodeId node) external view returns (bool result);
}
