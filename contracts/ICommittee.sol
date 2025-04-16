// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   ICommittee.sol - mirage-manager
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

import {DkgId, IDkg} from "./IDkg.sol";
import {INodes, NodeId} from "./INodes.sol";
import {IStaking} from "./IStaking.sol";
import {Duration, IStatus} from "./IStatus.sol";


type CommitteeIndex is uint256;
type Timestamp is uint256;

using {
    _timestampLess as <
} for Timestamp global;

interface ICommittee {
    struct Committee {
        NodeId[] nodes;
        DkgId dkg;
        IDkg.G2Point commonPublicKey;
        Timestamp startingTimestamp;
    }

    event VersionUpdated(string version, string newVersion);

    function initialize(address initialAuthority) external;
    function newNodeCreated(NodeId nodeId) external;
    function processSuccessfulDkg(DkgId dkg) external;
    function select() external;
    function setCommitteeSize(uint256 size) external;
    function setStaking(IStaking stakingAddress) external;
    function setDkg(IDkg dkgAddress) external;
    function setNodes(INodes nodesAddress) external;
    function setStatus(IStatus statusAddress) external;
    function setTransitionDelay(Duration delay) external;
    function setVersion(string calldata newVersion) external;
    function isNodeInCurrentOrNextCommittee(NodeId node) external view returns (bool result);
    function getActiveCommitteeIndex() external view returns (CommitteeIndex committeeIndex);
    function getCommittee(CommitteeIndex committeeIndex) external view returns (Committee memory committee);
}

// Slither flags as unused by interfaces but code is used
// in mirage-manager implementation to overload < operant

// slither-disable-start dead-code
function _timestampLess(Timestamp a, Timestamp b) pure returns (bool less) {
    return Timestamp.unwrap(a) < Timestamp.unwrap(b);
}
// slither-disable-end dead-code
